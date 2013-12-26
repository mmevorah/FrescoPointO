//
//  MainWindow.h
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/20/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FPOImage.h"
#import "ArduinoCommunicator.h"

@interface MainWindow : NSWindow{
    ArduinoCommunicator *arduino;
    
    NSImage* inImage;
    FPOImage* fpoImage;
    NSMutableArray *coordinates;
}

//Image
@property (strong) IBOutlet NSImageView *imageView;
- (IBAction)imageDraggedIn:(NSImageView *)sender;

//Controls
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong) IBOutlet NSProgressIndicator *sendProgressBar;
@property (strong) IBOutlet NSButton *generateButton;
@property (strong) IBOutlet NSButton *saveButton;
- (IBAction)send:(NSButton *)sender;
- (IBAction)generate:(NSButton *)sender;

//Parameters
@property (strong) IBOutlet NSTextField *beltField;
@property (strong) IBOutlet NSTextField *widthField;
@property (strong) IBOutlet NSTextField *pointSizeField;
- (IBAction)fieldChanged:(NSTextField *)sender;

//Arduino
@property (strong) IBOutlet NSTextField *portField;
@property (strong) IBOutlet NSTextField *baudField;


@end
