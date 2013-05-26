//
//  SlotDeckAppDelegate.h
//  SlotDeck
//
//  Created by Dimitris K on 11/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cards.h"

@interface SlotDeckAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBar;
	Cards *myCardsManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBar;
@property (nonatomic, retain) Cards *myCardsManager;


@end

