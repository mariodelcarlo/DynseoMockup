//
//  GameGenerator.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "GameLogic.h"
#import "Game.h"
#import "GameStep.h"
#import "GameStepArithmetic.h"

@interface GameLogic ()
@property(nonatomic, retain) NSTimer *currentStepTimer;
@property(nonatomic, assign) int stepElapsedTime;
@end

@implementation GameLogic

#pragma mark init methods
- (id)init{
    self = [super init];
    if (self) {
        self.currentGameStep = 0;
        self.stepElapsedTime = 0;
    }
    return self;
}

#pragma mark private methods
//Create an game with 10 aritmetic steps for a difficulty passed in param
- (void)createGameForDifficulty:(GameDifficulty)theDifficulty{
    self.currentGame = [[Game alloc] init];
    [self.currentGame setTimeAllowedForEachStep:60];
    self.currentGame.difficulty = theDifficulty;
    
    NSMutableArray * steps = [[NSMutableArray alloc] init];
    
    for (int nb_questions = 0; nb_questions < 10; nb_questions ++) {
        GameStepArithmetic * step = [self createGameStepForDifficulty:theDifficulty];
        [steps addObject:step];
    }
    [self.currentGame setSteps:steps];
}


//Generate a random number between 2 bounds, bounds are included
- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max{
    //arc4random_uniform returns value between 0 and the bounds set in parameter
    return min + arc4random_uniform(max - min + 1);
}


//Create an aritmetic step for a difficulty passed in param
-(GameStepArithmetic*)createGameStepForDifficulty:(GameDifficulty)theDifficulty{
    NSInteger leftNumber;
    NSInteger rightNumber;
    GameOperator operator;
    
    //Easy level, only additions and subtractions with numbers from 1 to 10
    //If subtraction, checks that right operand is smaller in order to have a positive number
    if(theDifficulty == GameDifficultyEasy){
        leftNumber = [self randomNumberBetween:1 maxNumber:10];
        operator = [self randomNumberBetween:0 maxNumber:1];
        rightNumber = [self randomNumberBetween:1 maxNumber:10];
        
        if(operator == GameOperatorSubtraction){
            rightNumber = [self randomNumberBetween:1 maxNumber:leftNumber];
        }
    }
    else if(theDifficulty == GameDifficultyNormal){
        //Normal level, additions and subtractions with numbers from 10 to 99
        //Multiplications with numbers from 1 to 10
        operator = [self randomNumberBetween:0 maxNumber:2];
        
        if(operator == GameOperatorAddition){
            leftNumber = [self randomNumberBetween:10 maxNumber:99];
            rightNumber = [self randomNumberBetween:10 maxNumber:99];
        }
        else if(operator == GameOperatorSubtraction){
            leftNumber = [self randomNumberBetween:10 maxNumber:99];
            rightNumber = [self randomNumberBetween:10 maxNumber:leftNumber];
        }
        else if(operator == GameOperatorMultiplication){
            leftNumber = [self randomNumberBetween:1 maxNumber:10];
            rightNumber = [self randomNumberBetween:1 maxNumber:10];
        }
    }
    else{
        //Normal level, additions and subtractions with numbers from 100 to 999
        //Multiplications with one number from 1 to 10 and one other from 10 to 99
        //Divisions: divisor is a number from 2 to 9w
        
        operator = [self randomNumberBetween:0 maxNumber:3];
    
        if(operator == GameOperatorAddition){
            leftNumber = [self randomNumberBetween:100 maxNumber:999];
            rightNumber = [self randomNumberBetween:100 maxNumber:999];
        }
        else if(operator == GameOperatorSubtraction){
            leftNumber = [self randomNumberBetween:100 maxNumber:999];
            rightNumber = [self randomNumberBetween:100 maxNumber:leftNumber];
        }
        else if(operator == GameOperatorMultiplication){
            leftNumber = [self randomNumberBetween:10 maxNumber:99];
            rightNumber = [self randomNumberBetween:1 maxNumber:10];
        }
        else if(operator == GameOperatorDivision){
            rightNumber =  [self randomNumberBetween:2 maxNumber:9];
            NSInteger numberTwo = [self randomNumberBetween:10 maxNumber:50];
            leftNumber = rightNumber * numberTwo;
        }
    }
    
    GameStepArithmetic *step1 = [[GameStepArithmetic alloc] init];
    [step1 setLeftOperand:leftNumber];
    [step1 setRightOperand:rightNumber];
    [step1 setGameOperator:operator];
    
    
    return step1;
}


//Timer for a step
-(void)stepTimerTick:(NSTimer *)timer {
    NSLog(@"stepElapsedTime =%d",self.stepElapsedTime);
    self.stepElapsedTime = self.stepElapsedTime + 1;
    if(self.stepElapsedTime == self.currentGame.timeAllowedForEachStep){
        [self showNextStep];
    }
}

//Method to show the next step if exists or end game
-(void)showNextStep{
    //Reset the timer
    self.stepElapsedTime = 0;
    [self.currentStepTimer invalidate];
    self.currentStepTimer = nil;
    
    //Got to the next step if there is one left
    if(self.currentGameStep < self.currentGame.steps.count - 1){
        //Change the step
        self.currentGameStep = self.currentGameStep + 1;
        
        if(self.gameDelegate != nil && [self.gameDelegate respondsToSelector:@selector(displayGameStepWithQuestion:)]){
            
            //Display next step of the game
            GameStepArithmetic * step1 = self.currentGame.steps[self.currentGameStep];
            [self.gameDelegate displayGameStepWithQuestion:step1.question];
        }
    }
    else{
        //The game is finished
        if(self.gameDelegate != nil && [self.gameDelegate respondsToSelector:@selector(gameEndedWithScore:)]){
            [self.gameDelegate gameEndedWithScore:self.currentGame.score];
        }
    }
}

//Called when a new step has been displayed and the animation is finished
-(void)newStepIsDisplayed{
    //Start the timer
    if(self.currentStepTimer !=nil){
        [self.currentStepTimer invalidate];
        self.currentStepTimer = nil;
    }
    self.currentStepTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stepTimerTick:) userInfo:nil repeats:YES];
}


-(void)endGame{
    NSLog(@"EndGame");
    [self.currentStepTimer invalidate];
    self.currentStepTimer = nil;
    self.stepElapsedTime = 0;
}

-(void)pauseGame{
    NSLog(@"PauseGame");
    [self.currentStepTimer invalidate];
    self.currentStepTimer = nil;
}


-(void)resumeGame{
    NSLog(@"resumeGame");
    if(self.currentStepTimer !=nil){
        [self.currentStepTimer invalidate];
        self.currentStepTimer = nil;
    }
    self.currentStepTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stepTimerTick:) userInfo:nil repeats:YES];
}

-(BOOL)wonTheStepForAnswer:(NSNumber*)theAnswer{
    GameStepArithmetic * step1 = self.currentGame.steps[self.currentGameStep];
    if([step1 rightAnswer] == theAnswer){
        return YES;
    }
    return NO;
}

#pragma mark public methods
//Start a game: create a game and display the first step
-(void)startWithDifficulty:(GameDifficulty)theDifficulty{
    [self createGameForDifficulty:theDifficulty];
    if(self.gameDelegate != nil && [self.gameDelegate respondsToSelector:@selector(displayGameStepWithQuestion:)]){
        
        //Display first step of the game
        GameStepArithmetic * step1 = self.currentGame.steps[0];
        [self.gameDelegate displayGameStepWithQuestion:step1.question];
    }
}
@end
