//
//  TimerWindowController.h
//  Timer
//
//  Created by Tim Burks on 12/20/09.
//

@interface TimerWindowController : NSWindowController {
	IBOutlet NSView *mainView;
	IBOutlet QCView *qcView;
	IBOutlet NSButton *button;
	IBOutlet NSProgressIndicator *progressIndicator;
	IBOutlet NSTextField *presenterTextField;
	IBOutlet NSTextField *topicTextField;
	NSTimeInterval startTime;
	NSTimer *eventTimer;
}
@property (nonatomic, assign) NSView *mainView;
@property (nonatomic, assign) QCView *qcView;
@property (nonatomic, assign) NSButton *button;
@property (nonatomic, assign) NSProgressIndicator *progressIndicator;
@property (nonatomic, assign) NSTextField *presenterTextField;
@property (nonatomic, assign) NSTextField *topicTextField;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, retain) NSTimer *eventTimer;

- (IBAction) toggleFullScreenDisplay:(id) sender;
- (IBAction) startTimer:(id) sender;

@end
