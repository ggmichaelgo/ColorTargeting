//
//  AppDelegate.h
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet QTCaptureView *captureView;
    IBOutlet NSImageView *imageView;
    
    QTCaptureSession *captureSession;
    QTCaptureMovieFileOutput *captureFileOutput;
    QTCaptureDeviceInput *captureVideoDeviceInput;
    QTCaptureDeviceInput *captureAudioDeviceInput;
}

@property (assign) IBOutlet NSWindow *window;

- (CIImage *)drawBox:(CIImage *) image;

@end
