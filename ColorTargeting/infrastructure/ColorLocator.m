//
//  ColorLocator.m
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import "ColorLocator.h"
#import "Color.h"
#import "Coordinate.h"

#define MAX_LEVEL 10

@implementation ColorLocator

@synthesize height, width;

-(ColorLocator*) init:(int)w height:(int)h
{
    self = [super init];
    if(self != nil)
    {
        self.width = w;
        self.height = h;
    }
    return self;
}

-(Coordinate*) levelSearch: (int) level MAP:(unsigned char *)map
{
    if(level == MAX_LEVEL)
        return nil;
    
    int pixIndex;
    Color *a, *b, *c, *d; //left-top -> right-top -> right-bottom -> left-bottom
    int len = height * width * 4;
    for (int y=0; y<height-(height/level) ; y+= height/level)
    {
        for(int x=0 ; x<width-(width/level) ; x+= width/level)
        {
            //GET COLORS OF 4 SQUARE'S CORNERS
            pixIndex = 4 * (y*width+x);
            a = [[Color alloc] initWithValues:map[pixIndex] green:map[pixIndex+1] blue:map[pixIndex+2]];
            
            pixIndex = 4 * (y*width + 2*x);
            b = [[Color alloc] initWithValues:map[pixIndex] green:map[pixIndex+1] blue:map[pixIndex+2]];
            
            pixIndex = 4 * (y*width + 2*x);
            c = [[Color alloc] initWithValues:map[pixIndex] green:map[pixIndex+1] blue:map[pixIndex+2]];
            
            pixIndex = 4 * (y*width + x);
            d = [[Color alloc] initWithValues:map[pixIndex] green:map[pixIndex+1] blue:map[pixIndex+2]];
            
            if([a isRed] && [b isRed] && [c isRed] && [d isRed])
            {
                if([a areEqual:b] && [b areEqual:c] && [c areEqual:d] && [d areEqual:a])
                {
                    Coordinate *coor = [[Coordinate alloc] initWithValues:width/level X:x Y:y];
                    [coor autorelease];
                    [a dealloc];
                    [b dealloc];
                    [c dealloc];
                    [d dealloc];
                    return coor;
                }
            }
        }
    }
    return [self levelSearch:level+1 MAP:map];
}

-(Coordinate*) findColor: (unsigned char*) map
{
    return [self levelSearch:1 MAP:map];
}

@end
