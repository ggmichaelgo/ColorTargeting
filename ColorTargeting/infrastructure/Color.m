//
//  Color.m
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import "Color.h"

@implementation Color

-(Color*) initWithValues: (int)r green:(int)g blue:(int)b
{
    self = [super init];
    if(self != nil)
    {
        self.red = r;
        self.green = g;
        self.blue = b;
    }
    return self;
}

-(BOOL) isRed
{
    Color *other = [[Color alloc] initWithValues:200 green:200 blue:200];
    int dist = abs(self.red-other.red) + abs(self.green-other.green) + abs(self.blue - other.blue);
    [other dealloc];
//    NSLog(@"%d", dist);
    if(dist < ACCURACY)
        return true;
    else
        return false;
}


-(BOOL) areEqual:(Color*) other
{
    int dist = abs(self.red-other.red) + abs(self.green-other.green) + abs(self.blue - other.blue);
    if(dist < ACCURACY)
        return true;
    else
        return false;
}

@end
