//
//  Coordinate.h
//  ColorTargeting
//
//  Created by Michael Go on 13-02-26.
//  Copyright (c) 2013 Michael Go. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject
{
    int x;
    int y;
    int size; 
}

@property(readwrite, assign) int x,y,size;

-(Coordinate*) initWithValues: (int)_size x:(int)_x y:(int)_y;

@end
