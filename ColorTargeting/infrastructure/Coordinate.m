//
//  Coordinate.m
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

-(Coordinate*) initWithValues: (int)size X:(int)x Y:(int)y
{
    self = [super init];
    if(self != nil)
    {
        self.size = size;
        self.x = x;
        self.y = y;
    }
    return self;
}

@end
