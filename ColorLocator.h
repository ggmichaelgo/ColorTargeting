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
    char *map;
}

-(Coordinate*) levelSearch: (int) level;
-(Coordinate*) findColor: (char*) map;

@end
