//
//  HighScores.m
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HighScores.h"
#import "SlotDeckAppDelegate.h"

@implementation HighScores


-(id) init {
	
	if([super init]) {
		
		self.tabBarItem.image = [UIImage imageNamed:@"200-card-clubs.png"];
		//icon from glyphish.com
		self.title = @"Scores";
		
	}
	
	return self;
	
}





@synthesize showHighscoresButton, highscoresText, swipeRecognizer ; 





//show score
- (void) showHighscoresButtonPressed {
	
	
	//Connecting of the mutable arrays of the HighScore class with the mutable arrays with keys "names" and "scores" which are NSUserDefaults
	NSArray *Names = [[NSUserDefaults standardUserDefaults] objectForKey:@"names"];
	NSArray *Scores = [[NSUserDefaults standardUserDefaults] objectForKey:@"scores"];
	//reverse arrays, this has as result to have on printing as first the bigger one score
	NSArray *rNames = [[Names reverseObjectEnumerator] allObjects];
	NSArray *rScores = [[Scores reverseObjectEnumerator] allObjects];
	NSMutableString *HighS = [NSMutableString stringWithCapacity:0];
	
	//this part is setting the one array object down of the other in the printing on the screen
	for (int i = 0; i < [rNames count]; i++) {
		[HighS appendString:[NSString stringWithFormat:@"%@ %@",[rNames objectAtIndex:i],[rScores objectAtIndex:i]]];
		[HighS appendString:@"\n"];
	}
	
	NSLog(@"Check %@",HighS);
	
	
	//print of HighS string on textview
	highscoresText.text = HighS;	
	
	
	
}


- (void) swipeRightDetected {
	
	// right swipe detection is leading to the tabBar obeject with index 3 that means the "how to" tab
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
	
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	//font changing at the HiscoresText
	highscoresText.font = [UIFont fontWithName:@"American Typewriter" size:22.0f];
	
	
	//connection of showHighscoresButton with showHighscoresButtonPressed method
	[showHighscoresButton addTarget:self action:@selector(showHighscoresButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	
	
	
	//calling and setting of the swipe recognizer
	swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightDetected)];

	swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;

    [self.view addGestureRecognizer:swipeRecognizer];
	
	
	
	
	//background image...
	
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"scoresBackground.png"]];
	
	
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
	
	self.highscoresText = nil;
	self.showHighscoresButton = nil;
	
}


- (void)dealloc {
    [super dealloc];
	
	[highscoresText release];
	[showHighscoresButton release];
	
}


@end
