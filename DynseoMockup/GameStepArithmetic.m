//
//  GameStepArithmetic.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "GameStepArithmetic.h"

@implementation GameStepArithmetic

#pragma mark init methods
- (id)init{
    self = [super init];
    if (self) {
        self.hasWon = NO;
    }
    return self;
}

#pragma mark utils methods
-(NSString *)question{
    return [self questionForLeft:self.leftOperand right:self.rightOperand operator:self.gameOperator];
}

-(NSString *)questionForLeft:(NSInteger)leftNumber right:(NSInteger)rightNumber operator:(GameOperator)operator{
    return [NSMutableString stringWithFormat:@"%d %@ %d = ?",leftNumber, [self stringForGameOperator:operator],rightNumber];
}


- (NSString*)stringForGameOperator:(GameOperator) operator{
    NSString *result = nil;
    
    switch(operator) {
        case GameOperatorAddition:
            result = @"+";
            break;
        case GameOperatorSubtraction:
            result = @"-";
            break;
        case GameOperatorMultiplication:
            result = @"X";
            break;
            
        case GameOperatorDivision:
            result = @"/";
            break;
            
        default:
            result = @"unknown";
    }
    return result;
}


-(NSInteger)resultForOperationWithLeft:(NSInteger)leftNumber right:(NSInteger)rightNumber operator:(GameOperator)operator{
    
    NSInteger result = -1;
    
    switch(operator) {
        case GameOperatorAddition:
            result = leftNumber + rightNumber;
            break;
        case GameOperatorSubtraction:
            result = leftNumber - rightNumber;
            break;
        case GameOperatorMultiplication:
            result = leftNumber * rightNumber;
            break;
            
        case GameOperatorDivision:
            result = leftNumber / rightNumber;
            break;
            
        default:
            result = -1;
    }
    return result;
}

@end
