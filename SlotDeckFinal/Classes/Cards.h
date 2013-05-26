//
//  Cards.h
//  SlotDeck
//
//  Created by Dimitris K on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Cards : NSObject {

	NSString *playerName;
	NSString *playerScore;
	
	
}
@property (nonatomic,retain) NSString *playerName;
@property (nonatomic,retain) NSString *playerScore;


@end
