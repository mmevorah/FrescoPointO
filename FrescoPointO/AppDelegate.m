//
//  AppDelegate.m
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/20/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize mainWindow = mainWindow_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    mainWindow_ = [[MainWindow alloc] init];
}

@end
