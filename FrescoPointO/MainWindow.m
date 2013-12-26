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
@synthesize beltField = beltField_;
@synthesize widthField = widthField_;
@synthesize pointSizeField = pointSizeField_;
@synthesize portField = portField_;
@synthesize baudField = baudField_;
@synthesize generateButton = generateButton_;

- (IBAction)fieldChanged:(NSTextField *)sender {
    
    NSString *bField = beltField_.stringValue;
    float bVal = beltField_.floatValue;
    
    NSString *wField = widthField_.stringValue;
    float wVal = widthField_.floatValue;
    
    NSString *pField = pointSizeField_.stringValue;
    float pVal = pointSizeField_.floatValue;
    
    NSString *portField = portField_.stringValue;
    
    NSString *baudField = baudField_.stringValue;
    float baudVal = baudField_.floatValue;
    
    if((![bField isEqualToString:@""]) &&
       (![wField isEqualToString:@""]) &&
       (![pField isEqualToString:@""]) &&
       (![portField isEqualToString:@""]) &&
       (![baudField isEqualToString:@""]) &&
       (bVal != 0) &&
       (wVal != 0) &&
       (pVal != 0) &&
       (baudVal != 0) &&
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
    
    //Make sure width and height is within the belt length
    float beltLength = beltField_.floatValue * 72;
    if(newWidth > beltLength){
        float newScale = beltLength / newWidth;
        newWidth = newWidth * newScale;
        newHeight = newHeight * newScale;
    }
    if(newHeight > beltLength){
        float newScale = beltLength / newHeight;
        newWidth = newWidth * newScale;
        newHeight = newHeight * newScale;
    }
    
    //Scale Image
    NSSize scaledSize = NSMakeSize(newWidth, newHeight);
    NSImage *scaledImage = [[NSImage alloc] initWithSize: scaledSize];
    [scaledImage lockFocus];
    [inImage setSize: scaledSize];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [inImage drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, scaledSize.width, scaledSize.height) operation:NSCompositeCopy fraction:1];
    [scaledImage unlockFocus];
    
    //Start Generation
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

- (IBAction)send:(NSButton *)sender {
    arduino = [[ArduinoCommunicator alloc] init];
    
    NSString *port = portField_.stringValue;
    NSInteger baudNum = baudField_.integerValue;
    NSString *error = [arduino openSerialPort:port baud:baudNum];
    if(error != nil){
        NSLog(@"%@", error);
    }else{
        [arduino sendCoordinates:coordinates];
        [saveButton_ setHidden:YES];
    }
}


- (int)mmToPixel:(float)mm{
    return ceil(mm * 3.779527559);
}

@end
