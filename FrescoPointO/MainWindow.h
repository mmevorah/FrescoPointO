//
//  MainWindow.h
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/20/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FPOImage.h"

@interface MainWindow : NSWindow{
    NSImage* inImage;
    FPOImage* fpoImage;
    NSMutableArray *coordinates;
}

@property (strong) IBOutlet NSImageView *imageView;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong) IBOutlet NSButton *saveButton;


@property (strong) IBOutlet NSTextField *widthField;

@property (strong) IBOutlet NSTextField *pointSizeField;
- (IBAction)fieldChanged:(NSTextField *)sender;


- (IBAction)imageDraggedIn:(NSImageView *)sender;

@property (strong) IBOutlet NSButton *generateButton;
- (IBAction)generate:(NSButton *)sender;
- (IBAction)save:(NSButton *)sender;

@end
