//
//  Tips.m
//  SlotDeck
//
//  Created by Dimitris K on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Tips.h"


@implementation Tips

@synthesize backButton;



//the method which return the view to the parent view  
- (IBAction)dismissView:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.backButton = nil;
	
	
}


- (void)dealloc {
    [super dealloc];
	
	[backButton release];
	
}


@end
