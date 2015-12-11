//
//  Game.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

//Enum for difficulty of the game
typedef NS_ENUM(NSUInteger, GameDifficulty) {
    GameDifficultyEasy = 0,
    GameDifficultyNormal = 1,
    GameDifficultyHard = 2,
};

//The difficulty
@property (nonatomic) GameDifficulty difficulty;

//The steps
@property(nonatomic, retain) NSArray * steps;

//Score
@property(nonatomic, assign) NSInteger score;

//Time allowed to answer the step in seconds
@property(nonatomic, assign) NSInteger timeAllowedForEachStep;


@end
