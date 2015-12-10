//
//  GameStep.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <Foundation/Foundation.h>

//Enum for difficulty of the game
typedef NS_ENUM(NSUInteger, GameStepState) {
    GameStepWon = 0,
    GameStepFailed = 1,
    GameStepUnknown = 2
};

//Generic game step if we have multiple types of game steps
@interface GameStep : NSObject
@end
