//
//  TimerAppDelegate.m
//  Timer
//
//  Created by Tim Burks on 12/20/09.
//

#import "TimerAppDelegate.h"
#import "TimerWindowController.h"

@implementation TimerAppDelegate

@synthesize window, timerWindowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {	
	self.timerWindowController = [[[TimerWindowController alloc] init] autorelease];
	[self.timerWindowController.window makeKeyAndOrderFront:self];
}

- (void) toggleFullScreenDisplay:(id) sender {
	[timerWindowController toggleFullScreenDisplay:sender];
}

@end
