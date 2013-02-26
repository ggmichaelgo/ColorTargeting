//
//  Color.h
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACCURACY 120

@interface Color : NSObject
{
    int red;
    int green;
    int blue;
}

@property(readwrite, assign) int red, green, blue;


-(Color*) initWithValues: (int)red green:(int)g blue:(int)b;
-(BOOL) areEqual:(Color*) other;
-(BOOL) isRed;

@end
