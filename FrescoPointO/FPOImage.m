//
//  FPOImage.m
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/21/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "FPOImage.h"

@implementation FPOImage

float threshold = .90;

-(BOOL)pixelIsBlackAtX:(int32_t)x andY:(int32_t)y{
    NSColor* c = [self colorAtX:x y:y];
    if((c.redComponent < (1 - threshold)) &&
       (c.greenComponent < (1 - threshold)) &&
       (c.blueComponent < (1 - threshold)) &&
       (c.alphaComponent > threshold)){
        return YES;
    }else{
        return NO;
    }
    
}


@end
