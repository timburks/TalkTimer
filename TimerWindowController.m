//
//  TimerWindowController.m
//  Timer
//
//  Created by Tim Burks on 12/20/09.
//

#import "TimerWindowController.h"

NSString *counterForTime(NSTimeInterval time) {
	int minutes = ((int) time) / 60;
	int seconds = ((int) time) % 60;
	return [NSString stringWithFormat:@"%01d:%02d", minutes, seconds];
}

const NSTimeInterval timeLimit = 120;

@implementation TimerWindowController
@synthesize mainView, qcView, button, progressIndicator, startTime, eventTimer;
@synthesize presenterTextField, topicTextField;

- (id) init {
	self = [self initWithWindowNibName:@"TimerWindow"];
	return self;
}

- (void)windowWillClose:(NSNotification *)notification 
{
	[NSApp terminate:self];
}

- (void) awakeFromNib {
	[qcView loadCompositionFromFile:[[NSBundle mainBundle] pathForResource:@"Timer" ofType:@"qtz"]];
	
	[qcView setValue:[NSColor redColor] forInputKey:@"Top_Color"];
	[qcView setValue:[NSColor yellowColor] forInputKey:@"Middle_Color"];
	[qcView setValue:[NSColor greenColor] forInputKey:@"Bottom_Color"];
	[qcView setValue:[NSNumber numberWithInt:5] forInputKey:@"Period"];
	[qcView setValue:[NSNumber numberWithInt:80] forInputKey:@"Font_Size"];
	[self updateDisplayForTime:timeLimit];
	[button setTitle:@"Start"];
}

- (void) toggleFullScreenDisplay:(id) sender {
	if ([mainView isInFullScreenMode]) {
		[mainView exitFullScreenModeWithOptions:nil];
	} else {
		[mainView enterFullScreenMode:[NSScreen mainScreen] withOptions:nil];
	}
}

int green[3]  = {0.0, 1.0, 0.0};
int yellow[3] = {1.0, 1.0, 0.0};
int red[3]    = {1.0, 0.0, 0.0};

- (void) updateDisplayForTime:(NSTimeInterval) time {
	double r, g, b, c;
	if (time > 0) {
		[qcView setValue:counterForTime(time) forInputKey:@"String"];
		[progressIndicator setDoubleValue:1.0 - (double) time / timeLimit];
	} else {
		[qcView setValue:counterForTime(-time) forInputKey:@"String"];
		[progressIndicator setDoubleValue:1.0];
	}
	if (time > 18) {
		r = green[0];
		g = green[1];
		b = green[2];
	} else if (time > 15) {
		c = (time - 15) / 3.0; 
		r = c*green[0] + (1-c)*yellow[0];
		g = c*green[1] + (1-c)*yellow[1];
		b = c*green[2] + (1-c)*yellow[2];
	} else if (time > 3) {
		r = yellow[0];
		g = yellow[1];
		b = yellow[2];
	} else if (time > 0) {
		c = (time - 0) / 3.0; 
		r = c*yellow[0] + (1-c)*red[0];
		g = c*yellow[1] + (1-c)*red[1];
		b = c*yellow[2] + (1-c)*red[2];
	} else {
		r = red[0];
		g = red[1];
		b = red[2];
	}
	[qcView setValue:[NSColor colorWithDeviceRed:r*1.0 green:g*1.0 blue:b*1.0 alpha:1.0] forInputKey:@"Top_Color"];
	[qcView setValue:[NSColor colorWithDeviceRed:r*0.7 green:g*0.7 blue:b*0.7 alpha:1.0] forInputKey:@"Middle_Color"];
	[qcView setValue:[NSColor colorWithDeviceRed:r*0.1 green:g*0.1 blue:b*0.1 alpha:1.0] forInputKey:@"Bottom_Color"];	
}

- (void) startTimer:(id) sender {
	if (!eventTimer) {		
		self.startTime = [NSDate timeIntervalSinceReferenceDate];
		self.eventTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0/10) target:self selector:@selector(tick:) userInfo:nil repeats:YES];
		[button setTitle:@"Stop"];
	} else {
		[eventTimer invalidate];
		self.eventTimer = nil;
		[self updateDisplayForTime:timeLimit];
		[button setTitle:@"Start"];
	}
}

- (void) tick:(id) sender {
	NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
	NSTimeInterval delta = currentTime - startTime;
	NSTimeInterval remaining = timeLimit - delta;
	[self updateDisplayForTime:remaining];
}

@end
