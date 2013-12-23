//
//  FPOImage.h
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/21/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FPOImage : NSBitmapImageRep

-(BOOL)pixelIsBlackAtX:(int32_t)x andY:(int32_t)y;

@end
