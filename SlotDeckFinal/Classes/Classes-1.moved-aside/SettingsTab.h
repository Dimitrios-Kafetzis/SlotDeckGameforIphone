//
//  SettingsTab.h
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsTab : UIViewController {
	
	UISwipeGestureRecognizer *swipeRecognizer;

}

@property (nonatomic,retain) UISwipeGestureRecognizer *swipeRecognizer;

- (void) swipeLeftDetected;
- (void) swipeRightDetected;

@end
