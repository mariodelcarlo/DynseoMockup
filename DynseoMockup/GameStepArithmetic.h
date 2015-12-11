//
//  GameStepArithmetic.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStep.h"

//Enum for the arithmetic operators
typedef NS_ENUM(NSUInteger, GameOperator) {
    GameOperatorAddition = 0,
    GameOperatorSubtraction = 1,
    GameOperatorMultiplication = 2,
    GameOperatorDivision = 3
};

//A game step that displays an arithmetic problem
//We support only an operation with 2 operands for the moment
@interface GameStepArithmetic : NSObject

//Left operand
@property(nonatomic, assign)NSInteger leftOperand;

//Right operand
@property(nonatomic, assign)NSInteger rightOperand;

//Operator (operator named reserved)
@property(nonatomic, assign)GameOperator gameOperator;

//Question asked
@property(nonatomic, copy) NSString * question;

//Right answer
@property(nonatomic, retain) NSNumber * rightAnswer;


@end
