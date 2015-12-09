//
//  Game.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "Game.h"

@implementation Game

//Init method
- (id)init{
    self = [super init];
    if (self) {
        self.playerName = NSLocalizedString(@"playerNameDefault", @"");
        self.difficulty = GameDifficultyEasy;
        self.score = 0;
    }
    return self;
}

//Init method with a player name and difficulty
- (id)initWithPlayerName:(NSString*)thePlayerName difficulty:(GameDifficulty)theDifficulty{
    self = [super init];
    if (self) {
        self.playerName = thePlayerName;
        self.difficulty = theDifficulty;
        self.score = 0;
    }
    return self;
}

@end
