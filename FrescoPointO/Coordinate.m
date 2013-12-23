//
//  Coordinate.m
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/21/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

@synthesize x;
@synthesize y;
@synthesize contact;

-(Coordinate*)initWithX:(int32_t) x_ Y: (int32_t) y_ andContact: (int) contact_{
    x = x_;
    y = y_;
    contact = contact_;
    return self;
}


@end
