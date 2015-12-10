//
//  GameGenerator.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@protocol GameLogicDelegate <NSObject>
-(void)displayGameStepWithQuestion:(NSString*)theQuestion;
-(void)gameEndedWithScore:(NSInteger)theScore;
@end

@interface GameLogic : NSObject

@property (nonatomic,retain) Game * currentGame;
@property(nonatomic,assign) id <GameLogicDelegate> gameDelegate;
@property (nonatomic,assign) int currentGameStep;

-(void)startWithDifficulty:(GameDifficulty)theDifficulty;
-(void)newStepIsDisplayed;
-(void)endGame;
-(void)resumeGame;
-(void)pauseGame;
-(BOOL)wonTheStepForAnswer:(NSNumber*)theAnswer;

@end
