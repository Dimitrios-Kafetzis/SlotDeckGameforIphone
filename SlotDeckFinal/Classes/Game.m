//
//  Game.m
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "SlotDeckAppDelegate.h"


@implementation Game



@synthesize item1; 
@synthesize item2; 
@synthesize item3; 
@synthesize item4; 
@synthesize slotMachine; 
@synthesize scoreLabel; 
@synthesize ScoreLabel; 
@synthesize usernameLabel;
@synthesize swipeRecognizer;
@synthesize spinButton;
@synthesize Names;
@synthesize Scores;
@synthesize myAlert;
@synthesize welcomeLabel;
@synthesize winnerrr;
@synthesize myImageView;
@synthesize myItems;
@synthesize myImageView2;
@synthesize myItems2;
@synthesize myImageView3;
@synthesize myItems3;
@synthesize myImageView4;
@synthesize myItems4;
@synthesize bet;
@synthesize myIntroAlert;
@synthesize myTextField;


int k = 10;
int score = 0;
int betInt = 0;


-(id) init {
	
	if([super init]) {
		
		//the tab icon is created on Photoshop
		self.tabBarItem.image = [UIImage imageNamed:@"symbol12 3.png"];
		
		self.title = @"Slot Machine";
		
		
		
	}
	
	return self;
	
}




-(void)spin {

	
	NSLog(@"test5");
	
	spinButton.hidden = NO; 
	//sound of coin, reference: youtube.com
	NSString *audioFileName = [[NSString alloc] initWithFormat:@"CoinSound"];
	NSString *mpthree = [[NSBundle mainBundle] pathForResource:audioFileName ofType:@"mp3"];
	
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:mpthree], &soundID);
	AudioServicesPlaySystemSound (soundID);
	
	[audioFileName release];
	
	
	//the main function of the game is based on an example of the book "Beginning iphone development exploring the iphone SDK" of Dave Mark and Jeff LaMarche pages:180-181
	
	BOOL winner = NO;
	
	int numberInRow = 1;
	
	int lastValue = -1;
	//method for the spinning... random selection
	for (int n = 0; n < 4; n++) {
		int newValue = random() % [self.item1 count];
		NSLog(@"%d",newValue);
		
		if (newValue == lastValue) {
			NSLog(@"newValue=lastValue");
			
			numberInRow++;
		}
		else 
			numberInRow = 1;
		
		lastValue = newValue;
		[slotMachine selectRow:newValue inComponent:n animated:YES];
		[slotMachine reloadComponent:n];
		if (numberInRow >= 3) 
			winner = YES;
		//this if gives the winner... if there are in the same serie the one near the other 3 same objects then BOOL winner = YES
		
	}
	
	
	if (winner) {
		
		//alert view for win
		myAlert = [[UIAlertView alloc]
				   
				   initWithTitle:@"WIN!!!" message:@"SLOT DECK"
				   
				   delegate:self cancelButtonTitle:@"Yeah!"
				   otherButtonTitles:nil];
		
		[myAlert show];
		[myAlert release];
		
		
		
		//score function which be related with the bet
		score += 20 + betInt;
		NSLog(@"score");
		NSLog(@"%d",score);
		
		
		
		scoreLabel.text = [NSString stringWithFormat:@" %d $", score];
		
		
		// create shared local copy of the app delegate
		SlotDeckAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		// create local data manager from the one stored in the app delegate
		Cards *myCardsManager = [appDelegate myCardsManager];
		[myCardsManager setPlayerScore:scoreLabel.text];
		
		
		
		//set of Names and Scores arrays which are printed on the HighScores class
		NSLog(@"back of names array");
		
		[self.Names addObject:[myCardsManager playerName]];
		
		NSLog(@"after names array back of scores array");

		[self.Scores addObject:[myCardsManager playerScore]];
		
		NSLog(@"after scores array");
		
		NSLog(@"Names Size = %d Scores Size = %d",[Names count],[Scores count]);
		
		
		
		//Setting Names array as NSUserDefaults
		[[NSUserDefaults standardUserDefaults] setObject:Names forKey:@"names"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		//Setting Scores array as NSUserDefaults
		[[NSUserDefaults standardUserDefaults] setObject:Scores forKey:@"scores"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		
		

        //vibration using AudioToolbox framework http://developer.apple.com/library/ios/#documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html    
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);     

		
	}
	
	
}


//the method of the animation which inform the player about the main rule of game
-(void) winnerAnimation {
	
	
	if (winnerrr.frame.origin.x > 30 && k == 10 ){
		k = -10;
	}
	
	if (winnerrr.frame.origin.x < 0 && k == -10){
		k = 10;
	}
	
	winnerrr.frame = CGRectMake(winnerrr.frame.origin.x+k, winnerrr.frame.origin.y, winnerrr.frame.size.width, winnerrr.frame.size.height);


}





//REFERENCE: the following method which is giving to user the opportunity to spin the slot machine just by shaking the device is based on a method from this site :  http://stackoverflow.com/questions/150446/how-do-i-detect-when-someone-shakes-an-iphone

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
	
	if (event.subtype == UIEventSubtypeMotionShake) {
		NSLog(@"shake it");
		
		[self spin];
	
	}



}
-(void) viewDidAppear:(BOOL)animated{
	[self becomeFirstResponder];
}

-(void) viewWillDisappear:(BOOL)animated{
	[self resignFirstResponder];
}

-(BOOL) canBecomeFirstResponder{
	
	return YES;

}
////////////////////////end of method...



#pragma mark -
#pragma mark Picker Data Source Methods

-(NSInteger) numberOfComponentsInPickerView: (UIPickerView *)  pickerView {
	//4 columns
	return 4;
}


-(NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component {
	
	return [self.item1 count];
	
}

#pragma mark Picker Delegate Methods

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent: (NSInteger) component reusingView : (UIView *)view {
	
	NSString *arrayName = [[NSString alloc] initWithFormat:@"item%d", component + 1];
	NSArray *array = [self valueForKey:arrayName];
	NSLog(@"test2");
	return [array objectAtIndex: row];
	NSLog(@"test1");
	
	
}



//turn the page left method
- (void) swipeLeftDetected {
	
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
	
}



//turn the page right method
- (void) swipeRightDetected {
	
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
	
}



- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:YES];
	
	NSLog(@"View will appear");
	// create shared local copy of the app delegate
	SlotDeckAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	// create local data manager from the one stored in the app delegate
	Cards *myCardsManager = [appDelegate myCardsManager];
	
	usernameLabel.text = [myCardsManager playerName];
	
	
	//alert view for Betting
	myIntroAlert = [[UIAlertView alloc]
					
					initWithTitle:@"Put your name in the intro page to play if you haven't done it... Bet if you want in the text field and Enjoy!" message:@"                                          "
					
					delegate:self cancelButtonTitle:@"OK"
					otherButtonTitles:nil ,nil];
	
	myTextField = [[UITextField alloc] initWithFrame:CGRectMake(110.0, 110.0, 63.0, 27.0)];
	[myTextField setBackgroundColor:[UIColor whiteColor]];
	myTextField.textAlignment = UITextAlignmentCenter;
	myTextField.font = [UIFont systemFontOfSize:22.0];
	myTextField.textColor = [UIColor redColor];
	[myTextField setKeyboardType:UIKeyboardTypePhonePad];
	[myTextField becomeFirstResponder];
	[myIntroAlert addSubview:myTextField];
	

	
	[myIntroAlert show];
	[myIntroAlert release];
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	bet = myTextField.text;
	NSLog(@"bet : %@",bet);
	
	betInt = [bet intValue];
	NSLog(@"print");
	NSLog(@"final bet: %d",betInt);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	//initialization of score
	score = 0;
	
	
	//create Names array
	Names = [[NSMutableArray alloc] init]; 
	
	//create Scores array
	Scores = [[NSMutableArray alloc] init];
	
	
	
	//Score Label
	scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(135,225,90,20)];
	scoreLabel.font = [UIFont fontWithName:@"American Typewriter" size:22.0];
	//set font properties
	scoreLabel.backgroundColor = [UIColor blackColor];
	//set background color
	
	scoreLabel.textColor = [UIColor redColor];
	//set text colour to be red
	
	[self.view addSubview:scoreLabel];
	
	
	//Username Label
	usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(130,18,400,20)];
	usernameLabel.font = [UIFont fontWithName:@"American Typewriter" size:22.0];
	//set font properties
	usernameLabel.backgroundColor = [UIColor blackColor];
	//set background color
	
	usernameLabel.textColor = [UIColor brownColor];
	//set text colour to be red
	
	[self.view addSubview:usernameLabel];
	
	
	//set of slot machine
	slotMachine = [[UIPickerView alloc] init];
	
	[slotMachine setFrame:CGRectMake(0,250,320,116)];
	
	[slotMachine setShowsSelectionIndicator:YES];
	
	[slotMachine setDelegate:self];
	
	[slotMachine setDataSource:self];
	
	slotMachine.backgroundColor = [UIColor redColor];	
	
	
	//set of slot machine array
    UIImage *spathi = [UIImage imageNamed:@"symbol12.png"];
    UIImage *kardia = [UIImage imageNamed:@"symbol22.png"];
    UIImage *trifilli = [UIImage imageNamed:@"symbol32.png"];
    UIImage *karo = [UIImage imageNamed:@"symbol42c.png"];
	UIImage *seven = [UIImage imageNamed:@"seven.png"];

	
	
	for (int n = 1; n <= 4 ;  n++) {
	
	
	
		UIImageView *spathiView = [[UIImageView alloc] initWithImage: spathi];
		UIImageView *kardiaView = [[UIImageView alloc] initWithImage: kardia];
		UIImageView *trifilliView = [[UIImageView alloc] initWithImage: trifilli];
		UIImageView *karoView = [[UIImageView alloc] initWithImage: karo];
		UIImageView *sevenView = [[UIImageView alloc] initWithImage: seven];
		
		
				
		NSArray *slotDeckGameArray = [[NSArray alloc] initWithObjects:spathiView,kardiaView,sevenView,trifilliView,karoView, nil];

		NSString *cardsSymbs =[[NSString alloc] initWithFormat:@"item%d", n];

		[self setValue:slotDeckGameArray forKey:cardsSymbs];

		
		[cardsSymbs release];
		
        
		[slotDeckGameArray release];
		
		
		[spathiView release];
		[kardiaView release];
		[trifilliView release];
		[karoView release];
		[sevenView release];
		
	
	
	}
		
		srandom(time(NULL));
	
	
	//set of the image which inform the player about the main rule of the game
	UIImage *Winner = [UIImage imageNamed:@"winnerOne.png"];
	
	winnerrr = [[UIImageView alloc] initWithImage: Winner];
	winnerrr.frame = CGRectMake(0, 40, 310, 25);
	
	
	//the NSTimer which is calling the method of the winner Animation
	[NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(winnerAnimation) userInfo:nil repeats:YES];
	
	
	[self.view addSubview:winnerrr];
	
	
		//Button spin
		spinButton = [UIButton buttonWithType:UIButtonTypeCustom];
		//create instance of UIButton class within the specified frame	
		spinButton.frame = CGRectMake(0, 0, 90, 90);
		//set position of the button
		
		spinButton.center = CGPointMake(320/2.0, 348/2.0);
		//set as half of the view width and height respectively	
		
	    
	
	
	
	
	
	    //REFERENCE: the image of the one pound coin is from this site: http://www.woburnheritagemuseum.co.uk/ 
	    UIImage *coinImage = [UIImage imageNamed:@"CoinFeedMe.png"]; 
	
	    [spinButton setImage:coinImage forState:UIControlStateNormal]; 
	    //creating a UIImage object using the imageNamed: method in State Normal
		
		[spinButton addTarget:self action:@selector(spin) forControlEvents:UIControlEventTouchUpInside];	
		
		
		slotMachine.userInteractionEnabled = NO;
		NSLog(@"2");
		
		
		[self.view addSubview:slotMachine];
		[self.view addSubview:spinButton];
	
	
	
	
	
	
	
	//Animated heart
	myItems = [[NSMutableArray alloc] init];
	
	myItems = [NSArray arrayWithObjects:
			   [UIImage imageNamed:@"symbol22.png"],
			   [UIImage imageNamed:@"blacklight.png"], nil ];
	
	myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 110, 40, 40)];
	
	myImageView.animationImages = myItems;
	
	myImageView.animationRepeatCount = 0;
	myImageView.animationDuration = 0.7;
	
	[myImageView startAnimating];
	
	
	[self.view addSubview:myImageView];
	
	
	//Animated spade
	myItems2 = [[NSMutableArray alloc] init];
	
	myItems2 = [NSArray arrayWithObjects:
			   [UIImage imageNamed:@"symbol12.png"],
			   [UIImage imageNamed:@"blacklight.png"], nil ];
	
	myImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 202, 40, 40)];
	
	myImageView2.animationImages = myItems2;
	
	myImageView2.animationRepeatCount = 0;
	myImageView2.animationDuration = 0.5;
	
	[myImageView2 startAnimating];
	
	
	[self.view addSubview:myImageView2];
	
	
	//Animated club
	myItems3 = [[NSMutableArray alloc] init];
	
	myItems3 = [NSArray arrayWithObjects:
			   [UIImage imageNamed:@"symbol32.png"],
			   [UIImage imageNamed:@"blacklight.png"], nil ];
	
	myImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(262, 110, 40, 40)];
	
	myImageView3.animationImages = myItems3;
	
	myImageView3.animationRepeatCount = 0;
	myImageView3.animationDuration = 0.5;
	
	[myImageView3 startAnimating];
	
	
	[self.view addSubview:myImageView3];
	
	
	//Animated diamond
	myItems4 = [[NSMutableArray alloc] init];
	
	myItems4 = [NSArray arrayWithObjects:
			   [UIImage imageNamed:@"symbol42c.png"],
			   [UIImage imageNamed:@"blacklight.png"], nil ];
	
	myImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(262, 202, 40, 40)];
	
	myImageView4.animationImages = myItems4;
	
	myImageView4.animationRepeatCount = 0;
	myImageView4.animationDuration = 0.7;
	
	[myImageView4 startAnimating];
	
	
	[self.view addSubview:myImageView4];
	
	
	
	
	
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
	
	self.slotMachine = nil;
	self.scoreLabel = nil;
	self.spinButton = nil;
	self.usernameLabel = nil;
	self.winnerrr = nil;
	self.myImageView = nil;
	self.myItems = nil;
	self.myImageView2 = nil;
	self.myItems2 = nil;
	self.myImageView3 = nil;
	self.myItems3 = nil;
	self.myImageView4 = nil;
	self.myItems4 = nil;
	self.myTextField = nil;
	
}

- (void)dealloc {
    [super dealloc];
	
	[slotMachine release];
	[item1 release];
	[item2 release];
	[item3 release];
	[item4 release];
	[scoreLabel release];
	[ScoreLabel release];
	[spinButton release];
	[usernameLabel release];
	[winnerrr release];
	[myImageView release];
	[myItems release];
	[myImageView2 release];
	[myItems2 release];
	[myImageView3 release];
	[myItems3 release];
	[myImageView4 release];
	[myItems4 release];
	[myTextField release];
	
}

	
	

@end
