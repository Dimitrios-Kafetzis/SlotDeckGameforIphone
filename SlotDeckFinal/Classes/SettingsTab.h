//
//  SettingsTab.h
//  SlotDeck
//
//  Created by Dimitris K on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTab : UIViewController {
	
	UISwipeGestureRecognizer *swipeRecognizer;
	

	IBOutlet UISlider *volumeSlider;
	IBOutlet UIButton *resetHighscoresButton;	
	IBOutlet UILabel *soundSettingsLabel;
	IBOutlet UILabel *highscoresLabel;
	IBOutlet UILabel *volumeLabel;
	IBOutlet UILabel *musicLabel;
	IBOutlet UILabel *resetLabel;
	
}

@property (nonatomic,retain) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic,retain) UISlider *volumeSlider;
@property (nonatomic,retain) UIButton *resetHighscoresButton;
@property (nonatomic,retain) UILabel *soundSettingsLabel;
@property (nonatomic,retain) UILabel *highscoresLabel;
@property (nonatomic,retain) UILabel *volumeLabel;
@property (nonatomic,retain) UILabel *musicLabel;
@property (nonatomic,retain) UILabel *resetLabel;






-(void) updateVolumeSlider;
-(void) reset;




@end
