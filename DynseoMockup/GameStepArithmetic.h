//
//  GameStepArithmetic.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStep.h"

//Enum for difficulty of the game
typedef NS_ENUM(NSUInteger, GameOperator) {
    GameOperatorAddition = 0,
    GameOperatorSubtraction = 1,
    GameOperatorMultiplication = 2,
    GameOperatorDivision = 3
};

#define gameOperatorToString(enum) [@[@"+",@"_",@"*","/"] objectAtIndex:enum]

@interface GameStepArithmetic : NSObject

//Left operand
@property(nonatomic, assign)NSInteger leftOperand;

//Right operand
@property(nonatomic, assign)NSInteger rightOperand;

//Operator (operator named reserved)
@property(nonatomic, assign)GameOperator gameOperator;

//Question
@property(nonatomic, copy) NSString * question;

//Proposed answered
@property(nonatomic, retain) NSArray * proposedAnswer;

//Right answer
@property(nonatomic, retain) NSString * rightAnswer;

//Has won the step
@property(nonatomic, assign) BOOL hasWon;

@end
