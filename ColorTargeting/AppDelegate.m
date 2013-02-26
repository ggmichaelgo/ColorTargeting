//
//  AppDelegate.m
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import "AppDelegate.h"
#import "infrastructure/Color.h"
#import "infrastructure/ColorLocator.h"
#import "infrastructure/Coordinate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self initQT];
}

- (void) initQT
{
    QTCaptureDevice *videoDevice = [QTCaptureDevice defaultInputDeviceWithMediaType:QTMediaTypeVideo];
    NSError *error = [[NSError alloc] init];
    bool success = [videoDevice open:&error];
    if(videoDevice)
    {
        captureSession = [[QTCaptureSession alloc] init];
        
        captureVideoDeviceInput = [[QTCaptureDeviceInput alloc] initWithDevice:videoDevice];
        [captureSession addInput:captureVideoDeviceInput error:&error];
        captureFileOutput = [[QTCaptureMovieFileOutput alloc] init];
        
        [captureView setCaptureSession:captureSession];
        NSLog(@"Init QT Called");
        [[[captureSession outputs] objectAtIndex:0] setPixelBufferAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [NSNumber numberWithInt:640], kCVPixelBufferHeightKey,
          [NSNumber numberWithInt:480], kCVPixelBufferWidthKey
          , nil]];
        
        [captureSession addOutput:captureFileOutput error:&error];
        NSLog(@"Init QT Done");
        [captureSession startRunning];
    }
}

- (CIImage *)drawBox:(CIImage *) ciImage BOX:(Coordinate *)box
{
    NSImage *image = [[[NSImage alloc] initWithSize: [ciImage extent].size] autorelease];
    [image lockFocus];
    CGContextRef contextRef = [[NSGraphicsContext currentContext] graphicsPort];
    CIContext *ciContext =	[CIContext contextWithCGContext:contextRef options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kCIContextUseSoftwareRenderer]];
    
    [ciContext drawImage:ciImage atPoint:CGPointMake(0, 0) fromRect:[ciImage extent]];
    [[NSColor redColor] setFill];
	//Does not leak when using the software renderer!
    [image setSize:NSMakeSize(640, 480)];
    [NSBezierPath fillRect:NSMakeRect(box.x, 480-box.y, box.size, box.size)];
    [image unlockFocus];
    
    NSData  * tiffData = [image TIFFRepresentation];
    NSBitmapImageRep * bitmap;
    bitmap = [NSBitmapImageRep imageRepWithData:tiffData];
    [imageView setImage:image];
    return [[CIImage alloc] initWithBitmapImageRep:bitmap];
}

- (CIImage *)view:(QTCaptureView *)view willDisplayImage:(CIImage *)ciImage
{
    CIContext *context_i = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context_i createCGImage:ciImage fromRect:ciImage.extent];
    int width = CGImageGetWidth(imageRef);
    int height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    ColorLocator *locator = [[ColorLocator alloc] init:width height:height];
    Coordinate *coor = [locator findColor:rawData];
    if(coor != nil)
        NSLog(@"%d %d %d", coor.x, coor.y, coor.size);

    [locator dealloc];
    [self drawBox:ciImage BOX:coor];
    return ciImage;
}

@end
