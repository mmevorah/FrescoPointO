//
//  ImageProcessor.h
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/21/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPOImage.h"

@interface ImageProcessor : NSObject

-(NSMutableArray*)generateCoordinates:(FPOImage*) rawImage pointSizeInPixels:(int)pointSize;

@end
