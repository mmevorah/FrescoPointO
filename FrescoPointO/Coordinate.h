//
//  Coordinate.h
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/21/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject{
    int32_t x;
    int32_t y;
    int     contact;
}

@property int32_t x;
@property int32_t y;
@property int contact;

-(Coordinate*)initWithX:(int32_t) x Y: (int32_t) y andContact: (int) contact;

@end
