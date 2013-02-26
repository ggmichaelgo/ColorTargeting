//
//  AppDelegate.m
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import "AppDelegate.h"

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


- (CIImage *)view:(QTCaptureView *)view willDisplayImage:(CIImage *)ciImage
{
    int width = [ciImage extent].size.width;
    int rows = [ciImage extent].size.height;
    int rowBytes = (width * 4);
    
    NSBitmapImageRep* rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil pixelsWide:width pixelsHigh:rows bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSCalibratedRGBColorSpace bitmapFormat:0 bytesPerRow:rowBytes bitsPerPixel:0];

    char *map =[rep bitmapData];
    
    
    
    return ciImage;
}

@end
