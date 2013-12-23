//
//  ImageProcessor.m
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/21/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "ImageProcessor.h"
#import "Coordinate.h"
#import "FPOImage.h"

@implementation ImageProcessor

-(NSMutableArray*)generateCoordinates:(FPOImage*) rawImage pointSizeInPixels:(int)pointSize{
    
    int imageWidth = rawImage.size.width;
    int imageHeight = rawImage.size.height;
    
    NSMutableArray* queue = [[NSMutableArray alloc] init];
    
    for(int32_t x = imageWidth; x >= 0; x -= pointSize){
        int32_t pX = x - (pointSize / 2);
        if(pX < 0){
            pX = 0;
        }
        BOOL black = NO;
        
        Coordinate *startCoordinate = [[Coordinate alloc] initWithX:pX Y:0 andContact:0];
        [queue addObject:startCoordinate];
        
        Coordinate *tmpCoordinate = [[Coordinate alloc] initWithX:pX Y:0 andContact:0];
        for(int32_t y = 0; y < imageHeight; y++){
            if([rawImage pixelIsBlackAtX:pX andY:y]){
                if(black == NO){
                    tmpCoordinate.x = pX;
                    tmpCoordinate.y = y;
                    tmpCoordinate.contact = 0;
                    [queue addObject:tmpCoordinate];
                    black = YES;
                    
                    tmpCoordinate = [[Coordinate alloc] initWithX:pX Y:y andContact:5];
                }
                
                tmpCoordinate.y = y;
                
            }else{
                if(black == YES){
                    tmpCoordinate.x = pX;
                    tmpCoordinate.y = y;
                    tmpCoordinate.contact = 5;
                    [queue addObject:tmpCoordinate];
                    black = NO;
                    
                    tmpCoordinate = [[Coordinate alloc] initWithX:pX Y:y andContact:0];
                }
                
                tmpCoordinate.y = y;
                
            }
        }
        
        int endContact = 0;
        if(black == YES){
            endContact = 5;
        }else{
            endContact = 0;
        }
        
        Coordinate *endCoordinate = [[Coordinate alloc] initWithX:pX Y:(imageHeight-1) andContact:endContact];
        [queue addObject:endCoordinate];
    }
    
    return queue;
}


@end
