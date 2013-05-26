//
//  Game.h
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>



@interface Game : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UIAccelerometerDelegate,UIAlertViewDelegate> {
	
	UIPickerView *slotMachine;
	UIButton *spinButton;
	UIAlertView *myAlert;
	NSArray *item1;
	NSArray *item2;
	NSArray *item3;
	NSArray *item4;
	

	UILabel *scoreLabel;
	UILabel *usernameLabel;
	IBOutlet UILabel *welcomeLabel;
	IBOutlet UILabel *ScoreLabel;
		
	
	UISwipeGestureRecognizer *swipeRecognizer;

	NSMutableArray *Names;
	NSMutableArray *Scores;
	
	UIImageView *winnerrr;
	
	UIImageView *myImageView;
	NSMutableArray *myItems;
	
	UIImageView *myImageView2;
	NSMutableArray *myItems2;
	
	UIImageView *myImageView3;
	NSMutableArray *myItems3;
	
	UIImageView *myImageView4;
	NSMutableArray *myItems4;
	
	NSString *bet;
	
	UITextField *myTextField;
		
}

@property (nonatomic,retain) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic,retain) UIPickerView *slotMachine;
@property (nonatomic,retain) NSArray *item1, *item2, *item3, *item4;
@property (nonatomic,retain) UIButton *spinButton;
@property (nonatomic,retain) UIAlertView *myAlert;
@property (nonatomic,retain) UILabel *scoreLabel;
@property (nonatomic,retain) UILabel *usernameLabel;
@property (nonatomic,retain) UILabel *welcomeLabel;
@property (nonatomic,retain) UILabel *ScoreLabel;
@property (nonatomic,retain) NSMutableArray *Names;
@property (nonatomic,retain) NSMutableArray *Scores;
@property (nonatomic,retain) UIImageView *winnerrr;
@property (nonatomic,retain) UIImageView *myImageView;
@property (nonatomic,retain) NSMutableArray *myItems;
@property (nonatomic,retain) UIImageView *myImageView2;
@property (nonatomic,retain) NSMutableArray *myItems2;
@property (nonatomic,retain) UIImageView *myImageView3;
@property (nonatomic,retain) NSMutableArray *myItems3;
@property (nonatomic,retain) UIImageView *myImageView4;
@property (nonatomic,retain) NSMutableArray *myItems4;
@property (nonatomic,retain) NSString *bet;
@property (nonatomic,retain) UIAlertView *myIntroAlert;
@property (nonatomic,retain) UITextField *myTextField;

- (void) spin;
- (void) swipeLeftDetected;
- (void) swipeRightDetected;
- (void) winnerAnimation;



@end
