//
//  TimerAppDelegate.h
//  Timer
//
//  Created by Tim Burks on 12/20/09.
//

@class TimerWindowController;

@interface TimerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	TimerWindowController *timerWindowController;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) TimerWindowController *timerWindowController;

- (IBAction) toggleFullScreenDisplay:(id) sender;

@end
