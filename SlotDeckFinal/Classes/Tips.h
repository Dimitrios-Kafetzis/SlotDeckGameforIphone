//
//  Tips.h
//  SlotDeck
//
//  Created by Dimitris K on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Tips : UIViewController {
	
	UIButton *backButton;
	
}

@property (nonatomic,retain) IBOutlet UIButton *backButton;


- (IBAction)dismissView:(id)sender;




@end
