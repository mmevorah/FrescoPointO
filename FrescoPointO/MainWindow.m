//
//  MainWindow.m
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/20/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "MainWindow.h"
#import "FPOImage.h"
#import "ImageProcessor.h"
#import "Coordinate.h"

@implementation MainWindow

@synthesize imageView = imageView_;
@synthesize progressIndicator = progressIndicator_;
@synthesize saveButton = saveButton_;
@synthesize widthField = widthField_;
@synthesize pointSizeField = pointSizeField_;

@synthesize generateButton = generateButton_;

- (IBAction)fieldChanged:(NSTextField *)sender {
    
    NSString *wField = widthField_.stringValue;
    float wInt = widthField_.floatValue;
    
    NSString *pField = pointSizeField_.stringValue;
    float pInt = pointSizeField_.floatValue;
    
    
    if((![wField isEqualToString:@""]) &&
       (![pField isEqualToString:@""]) &&
       (wInt != 0) &&
       (pInt != 0) &&
       ([inImage isNotEqualTo:nil])){
        
        [generateButton_ setEnabled:YES];
    
    }else{
        [generateButton_ setEnabled:NO];
    }
}

- (IBAction)imageDraggedIn:(NSImageView *)sender {
    inImage = sender.image;
    
    NSBitmapImageRep *tmpRep = [NSBitmapImageRep imageRepWithData:[inImage TIFFRepresentation]];
    if([tmpRep.colorSpaceName.lowercaseString isEqualToString:NSCalibratedWhiteColorSpace.lowercaseString]){
        NSLog(@"Invalid");
    }else{
        if((![self.pointSizeField.stringValue isEqualToString:@""]) &&
           (self.pointSizeField.integerValue != 0)){
            [generateButton_ setEnabled:YES];
        }
    }
    
    //[self setFrame:NSMakeRect(windowX, windowY, newWindowWidth, newWindowHeight) display:YES];
}

- (IBAction)generate:(NSButton *)sender {
    ImageProcessor* imageProcessor = [[ImageProcessor alloc] init];
    
    
    float oldWidth = inImage.size.width;
    float oldHeight = inImage.size.height;
    
    float scale = (widthField_.floatValue * 72 )/ inImage.size.width;

    float newWidth = oldWidth * scale;
    float newHeight = oldHeight * scale;
    
    NSSize scaledSize = NSMakeSize(newWidth, newHeight);
    
    NSImage *scaledImage = [[NSImage alloc] initWithSize: scaledSize];
    
    [scaledImage lockFocus];
    [inImage setSize: scaledSize];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [inImage drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, scaledSize.width, scaledSize.height) operation:NSCompositeCopy fraction:1];
    [scaledImage unlockFocus];
    
    fpoImage = [[FPOImage alloc] initWithData:[scaledImage TIFFRepresentation]];
    
    [progressIndicator_ setHidden:NO];
    [progressIndicator_ startAnimation:nil];
    
    float pixInMM = self.pointSizeField.floatValue;
    int pix = [self mmToPixel:pixInMM];
    coordinates = [imageProcessor generateCoordinates:fpoImage pointSizeInPixels:pix];
    [progressIndicator_ stopAnimation:nil];
    [progressIndicator_ setHidden:YES];
    [saveButton_ setHidden:NO];
}

- (IBAction)save:(NSButton *)sender {
    NSMutableString* output = [[NSMutableString alloc] init];
    for(int i = 0; i < coordinates.count; i++){
        Coordinate* c = [coordinates objectAtIndex:i];
        NSString* coordStr = [NSString stringWithFormat:@"%i %i %i\n", c.x, c.y, c.contact];
        [output appendString:coordStr];
    }
    NSLog(@"%@", output);
    
    [saveButton_ setHidden:YES];
}

- (int)mmToPixel:(float)mm{
    return ceil(mm * 3.779527559);
}

@end
