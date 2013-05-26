//
//  IntroTab.h
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface IntroTab : UIViewController {
	
	UIButton *gameButton;
	UIButton *highScoresButton;
    UIButton *settingsButton;
	
	UISwipeGestureRecognizer *swipeRecognizer;
	UIAlertView *myIntroAlert;

	
	UISlider *mySlider;
	
	
	IBOutlet UITextField *usernameTextField;
	IBOutlet UILabel *gameLogo;
	
	AVAudioPlayer *myPlayer;
	 
	NSTimer *musicTimer;
	
	UIButton *tipsButton;
			
}

@property (nonatomic,retain) IBOutlet UIButton *gameButton;
@property (nonatomic,retain) UIButton *highScoresButton;
@property (nonatomic,retain) UIButton *settingsButton;
@property (nonatomic,retain) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic,retain) UIAlertView *myIntroAlert;
@property (nonatomic,retain) UITextField *usernameTextField;
@property (nonatomic,retain) UILabel *gameLogo;
@property (nonatomic,retain) AVAudioPlayer *myPlayer;
@property (nonatomic,retain) UISlider *mySlider;
@property (nonatomic,retain) NSTimer *musicTimer;
@property (nonatomic,retain) IBOutlet UIButton *tipsButton;





- (void) tipsButtonPressed;
- (void) gameButtonPressed;
- (void) settingsButtonPressed;
- (void) highScoresButtonPressed; 
- (void) swipeLeftDetected;
- (void) introMusic;








@end
