//
//  ArduinoCommunicator.h
//  FrescoPointO
//
//  Created by Mark Mevorah on 12/26/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

#import <Foundation/Foundation.h>
//#include <IOKit/IOKitLib.h>
//#include <IOKit/serial/IOSerialKeys.h>
//#include <IOKit/IOBSD.h>
#include <IOKit/serial/ioss.h>
#include <sys/ioctl.h>
#include "Coordinate.h"

@interface ArduinoCommunicator : NSObject{
    struct termios gOriginalTTYAttrs; // Hold the original termios attributes so we can reset them on quit ( best practice )
    int serialFileDescriptor; // file handle to the serial port
    bool readThreadRunning;
    NSMutableArray *coordinates;
    
@private
    NSInteger coordinateIndex;
}

-(id)init;

- (NSString *) openSerialPort: (NSString *)serialPortFile baud: (speed_t)baudRate;

- (void) sendCoordinates:(NSMutableArray*)coordinates_;

- (void)appendToIncomingText: (id) text;
- (void)incomingTextUpdateThread: (NSThread *) parentThread;

@end
