//
//  ColorLocator.h
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@interface ColorLocator : NSObject
{
    int height;
    int width;
}

@property (readwrite, assign) int height, width;

-(ColorLocator*) init:(int)w height:(int)h;
-(Coordinate*) levelSearch: (int) level MAP:(unsigned char *)map;
-(Coordinate*) findColor: (unsigned char*) map;

@end
