//
//  SettingsTab.m
//  SlotDeck
//
//  Created by Dimitris K on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsTab.h"


@implementation SettingsTab

@synthesize swipeRecognizer;
@synthesize volumeSlider;
@synthesize resetHighscoresButton;
@synthesize soundSettingsLabel;
@synthesize highscoresLabel;
@synthesize volumeLabel;
@synthesize musicLabel;
@synthesize resetLabel;


-(id) init {
	
	if([super init]) {
		
		self.tabBarItem.image = [UIImage imageNamed:@"slotDeckSettingsIcon.png"];
		//REFERENCE: the icon is from glyphish.com
		self.title = @"Settings";
				
	}
	
	return self;
	
}







-(void) updateVolumeSlider {
	
	//set of volumeSlider.value as NSUser defaults... and as a result the player can have the control of the music volume via a tab but for all the other tabs
	[[NSUserDefaults standardUserDefaults] setFloat:volumeSlider.value forKey:@"volume"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"Slider value = %f",volumeSlider.value);
	
}





-(void) reset {
	//reset method just by set as Object nil...
	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"names"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"scores"];
	[[NSUserDefaults standardUserDefaults] synchronize];

}



- (void) swipeLeftDetected {
 
 self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
 
 }
 
 
 - (void) swipeRightDetected {
 
 self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
 
 }


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	

	//Volume Slider
	volumeSlider.minimumValue = 0.0;
	volumeSlider.maximumValue = 1.0;
	
	
	
	[volumeSlider addTarget:self action:@selector(updateVolumeSlider) forControlEvents:UIControlEventValueChanged];
	
	[[NSUserDefaults standardUserDefaults]setObject:volumeSlider forKey:@"normalValue" ];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	
	
	
	//reset button connected with the reset method
	[resetHighscoresButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
	
	
	
	
	
	swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftDetected)];
	
	swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	
	[self.view addGestureRecognizer:swipeRecognizer];
	
	
	
	swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightDetected)];
	
	swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
	
	[self.view addGestureRecognizer:swipeRecognizer];
	
	
	
	
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.swipeRecognizer = nil;
	self.volumeSlider = nil;
	self.resetHighscoresButton = nil;
	self.soundSettingsLabel = nil;
	self.highscoresLabel = nil;
	self.volumeLabel = nil;
	self.musicLabel = nil;
	self.resetLabel = nil;
	
	
}


- (void)dealloc {
    [super dealloc];
	
	
	[swipeRecognizer release];
	[volumeSlider release];
	[resetHighscoresButton release];
	[soundSettingsLabel release];
	[highscoresLabel release];
	[volumeLabel release];
	[musicLabel release];
	[resetLabel release];
	
	
}


@end
