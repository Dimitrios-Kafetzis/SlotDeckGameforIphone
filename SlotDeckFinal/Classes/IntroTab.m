//
//  IntroTab.m
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "IntroTab.h"
#import "SlotDeckAppDelegate.h"
#import "Tips.h"


@implementation IntroTab



@synthesize gameButton;
@synthesize highScoresButton;
@synthesize settingsButton;
@synthesize swipeRecognizer;
@synthesize myIntroAlert;
@synthesize usernameTextField;
@synthesize mySlider;
@synthesize gameLogo;
@synthesize musicTimer;
@synthesize myPlayer;
@synthesize tipsButton;

-(id) init {
	
	if([super init]) {
		
		self.tabBarItem.image = [UIImage imageNamed:@"introIcon.png"];
		//REFERENCE: the icon is from glyphish.com
		self.title = @"Intro";
		
	}
	
	return self;
	
}


// REFERENCE: The following method for the changing of the position of the textfield when the keyboard is appearing is taken from the following site at 26 November 2010,  http://stackoverflow.com/questions/1126726/how-to-make-a-uitextfield-move-up-when-keyboard-is-present

#pragma mark UIKeyboard handling

#define kMin 150

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
	if (usernameTextField) {
		[usernameTextField release];
	}
	usernameTextField = [sender retain];
	//move the main view, so that the keyboard does not hide it.
	if (self.view.frame.origin.y + usernameTextField.frame.origin. y >= kMin) {
        [self setViewMovedUp:YES]; 
	}
}



//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; // if you want to slide up the view
	
	CGRect rect = self.view.frame;
	if (movedUp)
	{
		// 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
		// 2. increase the size of the view so that the area behind the keyboard is covered up.
		rect.origin.y = kMin - usernameTextField.frame.origin.y ;
	}
	else
	{
		// revert back to the normal state.
		rect.origin.y = 0;
	}
	self.view.frame = rect;
	
	[UIView commitAnimations];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
	//keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	
	if ([usernameTextField isFirstResponder] && usernameTextField.frame.origin.y + self.view.frame.origin.y >= kMin)
	{
		[self setViewMovedUp:YES];
	}
	else if (![usernameTextField isFirstResponder] && usernameTextField.frame.origin.y  + self.view.frame.origin.y < kMin)
	{
		[self setViewMovedUp:NO];
	}
}

- (void)keyboardWillHide:(NSNotification *)notif
{
	//keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	if (self.view.frame.origin.y < 0 ) {
		[self setViewMovedUp:NO];
	}
	
}


- (void)viewWillAppear:(BOOL)animated
{
	// register for keyboard notifications
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) 
												 name:UIKeyboardWillHideNotification object:self.view.window];
	//I have set here the .volume because I want to be updated any time the intro tab is appearing
	myPlayer.volume = [[NSUserDefaults standardUserDefaults] floatForKey:@"volume"];
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////end of method for the changing of the position of the textfield

//MUSIC player
-(void) introMusic {

	[myPlayer play];
	
}


  



- (void) gameButtonPressed {
	
	self.tabBarController.selectedIndex = 2;

}

- (void) settingsButtonPressed {
	
	self.tabBarController.selectedIndex = 1;
	
}
- (void) highScoresButtonPressed {
	
	self.tabBarController.selectedIndex = 4;
	
}


- (void) swipeLeftDetected {
	
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
	
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];  // get touch object
	
	if ([usernameTextField isFirstResponder] && [touch view] != usernameTextField) {
		
		
		// create shared local copy of the app delegate
		SlotDeckAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		// create local data manager from the one stored in the app delegate
		Cards *myCardsManager = [appDelegate myCardsManager];
		[myCardsManager setPlayerName:usernameTextField.text];
		
		
		[usernameTextField resignFirstResponder];
	}
	
}

//method which is calling when the tips button is pressed and it is rolling to the child view which is the Tips class
-(void) tipsButtonPressed {
	
	Tips *tipsView = [[Tips alloc] init];
	
	tipsView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	
	[self presentModalViewController:tipsView animated:YES];
	[tipsView release];
	
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	

	
	//creating of a string that contains the path to the file
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"VivaLasVegas" ofType:@"mp3"];
	//creating of a NSURL object from this file path
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
	//initialising of the audio player
	myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	
	// preloading of the buffer and preparing for playing.
	[self.myPlayer prepareToPlay];
	[myPlayer setMeteringEnabled:YES];
	
	[filePath release];
	
	[fileURL release];
	
	//the NSTimer which is calling the introMusic function... the scheduledTimerWithTimeInterval is 0 because I want to be repeated the mp3 file without any delay
	musicTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(introMusic) userInfo:nil repeats:YES];

	
	
    //set of swipe recognizer
	swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftDetected)];
	
	swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	
	[self.view addGestureRecognizer:swipeRecognizer];
	
	
	
	
	
	//GAME BUTTON
	
	[gameButton addTarget:self action:@selector(gameButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:gameButton];
	
	
	
	
	//TIPS BUTTON
	
	[tipsButton addTarget:self action:@selector(tipsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
		
	

	
	//background image... reference: http://www.fsc.yorku.ca
	
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"slotdeckLoGo2.png"]];


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
	
	self.gameButton = nil;
	self.highScoresButton = nil;
	self.settingsButton = nil;
	self.swipeRecognizer = nil;
	self.myIntroAlert = nil;
	self.usernameTextField = nil;
	self.mySlider = nil;
	self.gameLogo = nil;
	self.myPlayer = nil;
	self.tipsButton = nil;
	
}


- (void)dealloc {
    [super dealloc];
	
	[gameButton release]; 
	[highScoresButton release]; 
	[settingsButton release]; 
	[swipeRecognizer release]; 
	[myIntroAlert release]; 
	[usernameTextField release]; 
	[mySlider release];
	[gameLogo release];
	[myPlayer release];
	[tipsButton release];

	
}


@end
