//
//  Howto.m
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Howto.h"


@implementation Howto

-(id) init {
	
	if([super init]) {
		
		self.tabBarItem.image = [UIImage imageNamed:@"96-book.png"];
		//REFERENCE: the icon is from glyphish.com
		self.title = @"info";
		
	}
	
	return self;
	
}





@synthesize myWebView, myToolbar;

- (void) swipeLeftDetected {
	
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:4];
	//Left detection... is going to the next tab... the user's finger it's like to pick up the view from right to left 
}


- (void) swipeRightDetected {
	
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
	//Right detection... is going to the previous tab... the user's finger it's like to pick up the view from left to right
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
	//ToolBar
	myToolbar = [UIToolbar new];
	myToolbar.barStyle = UIBarStyleDefault;
	[myToolbar sizeToFit];
	myToolbar.frame = CGRectMake(0, 0, 320, 30);
	myToolbar.tintColor = [UIColor blackColor]; 
	myToolbar.alpha = 0.7;
	//Creation of the toolbar using new
	
	
	//TextField
	UITextField *pagesView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
	pagesView.delegate = self;
	pagesView.clearsOnBeginEditing = YES;
	pagesView.borderStyle = UITextBorderStyleRoundedRect;
	//pagesView.textAlignment = UITextAlignmentCenter;
	pagesView.userInteractionEnabled = YES;
    pagesView.returnKeyType = UIReturnKeyDone;
	
	
	
	//Toolbar items
	UIBarButtonItem *systemItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBackButton)];
	
	
	UIBarButtonItem *systemItem0 = [[UIBarButtonItem alloc] initWithCustomView:pagesView];
	
	UIBarButtonItem *systemItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButton)];
	
	
	UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	UIBarButtonItem *systemItem4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(goForwardButton)];	
	//Add buttons
	
	NSArray *items = [NSArray arrayWithObjects: systemItem1, systemItem0, systemItem2, flexItem2, systemItem4,  nil];
	//Add buttons to the array
	
	
	[myToolbar setItems:items animated:YES];
	//add array of buttons to toolbar
	
	
	
	[systemItem1 release];
	[systemItem2 release];
	[systemItem4 release];
	[systemItem0 release];
	[flexItem2 release];
	
	
	
	//set of webview
	
	myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,31,320,449)];
	
	NSString *urlString = @"http://www.casinoinstruction.com/slots.html";
	
	NSURL *url = [NSURL URLWithString:urlString];
	
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	
	[myWebView loadRequest:urlRequest];	
	
	
	myWebView.backgroundColor = [UIColor blackColor];  
	
	myWebView.scalesPageToFit = YES;
	
	
	
	
	[self.view addSubview:myToolbar];
	[self.view addSubview:myWebView];
	//add webview to view	
	
	
	
	//set of the swipe recognizers
	swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftDetected)];
	
	swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	
	[self.view addGestureRecognizer:swipeRecognizer];
	
	
	
	swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightDetected)];
	
	swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
	
	[self.view addGestureRecognizer:swipeRecognizer];
	
	
}

- (void) goBackButton {
	
	[myWebView goBack];
	
}

- (void) goForwardButton {
	
	[myWebView goForward];
	
}

- (void) reloadButton {
	
	[myWebView reload];
	
}


//the method about the URL request
- (void) setPage : (NSString *)urlString {	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[myWebView loadRequest:urlRequest];
}




- (BOOL)textFieldShouldReturn:(UITextField *)pagesView{
	
	
	
	
	//correction method of the url
	[pagesView resignFirstResponder];
    if ([pagesView.text hasPrefix:@"http://"] || [pagesView.text hasPrefix:@"Http://"])
	{     
		[self setPage:pagesView.text];
		
	}
	else {
		[self setPage:[NSString stringWithFormat:@"http://%@", pagesView.text]];  
	}
	
	
	[self setPage:pagesView.text];
	
	return NO;
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	self.myWebView = nil;//free up memory of retained objects when view unloads		
	
}


- (void)dealloc {
    [super dealloc];
	
	[myWebView release];
	[myToolbar release];
	
}

@end
