//
//  ColorLocator.m
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import "ColorLocator.h"

#define MAX_LEVEL 5

@implementation ColorLocator

-(ColorLocator*) init: (char*) m width:(int)w height:(int)h
{
    width = w;
    height = h;
    map = m;
}

-(Coordinate*) levelSearch: (int) level
{
    if(level == MAX_LEVEL)
        return nil;
    
    for (int y=0; y<height ; y++)
    {
        for(int x=0 ; x<width ; x++)
        {
            
        }
    }
}

-(Coordinate*) findColor: (char*) map
{
    levelSearch(0);
}

@end
