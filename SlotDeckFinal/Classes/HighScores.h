//
//  HighScores.h
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScores : UIViewController {
	
	UIButton *showHighscoresButton;
	UITextView *highscoresText;
	UISwipeGestureRecognizer *swipeRecognizer;
	

}

@property (nonatomic,retain) IBOutlet UIButton *showHighscoresButton;
@property (nonatomic,retain) IBOutlet UITextView *highscoresText;
@property (nonatomic,retain) UISwipeGestureRecognizer *swipeRecognizer;
	


- (void) swipeRightDetected;
- (void) showHighscoresButtonPressed;




@end
