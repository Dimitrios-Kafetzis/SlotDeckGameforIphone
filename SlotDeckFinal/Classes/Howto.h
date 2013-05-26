//
//  Howto.h
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Howto : UIViewController <UITextFieldDelegate> {
	
	UIWebView *myWebView; //create UIWebView ivar
	UIToolbar *myToolbar; //create UIToolbar ivar
	UISwipeGestureRecognizer *swipeRecognizer;
	
}

@property (nonatomic,retain) UIWebView *myWebView;
@property (nonatomic,retain) UIToolbar *myToolbar;
@property (nonatomic,retain) UISwipeGestureRecognizer *swipeRecognizer;
	
- (void) swipeLeftDetected;
- (void) swipeRightDetected;
- (void) goBackButton;
- (void) goForwardButton;
- (void) setPage : (NSString *)urlString;

@end
