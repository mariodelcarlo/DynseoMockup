//
//  GameViewController.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "GameViewController.h"
#import "GameStep.h"
#import "ProgressView.h"

#define ALERT_CLOSING_GAME 123
#define ALERT_FINISHING_GAME 456

@interface GameViewController ()
@property (nonatomic, retain)GameLogic *gameLogic;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic, strong) CustomKeyboardViewController *keyboardViewController;
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@end

@implementation GameViewController

#pragma mark view life methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionLabel.text = @"";
    self.gameLogic = [[GameLogic alloc] init];
    self.gameLogic.gameDelegate = self;
    [self.gameLogic startWithDifficulty:self.gameDifficulty];
    
    //Set up progress view
    [self.progressView setMinValue:0];
    [self.progressView setMaxValue:self.gameLogic.currentGame.timeAllowedForEachStep];
    [self.progressView setCurrentValue:0];
    [self.progressView setProgressRemainingColor:[UIColor colorWithRed:104/255.f green:188/255.f blue:216/255.f alpha:1]];
    [self.progressView setProgressColor:[UIColor colorWithRed:116/255.f green:94/255.f blue:139/255.f alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EmbedKeyboardViewSegue"]) {
        self.keyboardViewController = (CustomKeyboardViewController *)segue.destinationViewController;
        self.keyboardViewController.delegate = self;
    }
}


#pragma mark actions
- (IBAction)quitGameTouchedUpInside:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"exitGameTitle", @"exitGameTitle") message:NSLocalizedString(@"exitGameMessage", @"exitGameMessage") delegate:self cancelButtonTitle:NSLocalizedString(@"no", @"no") otherButtonTitles:NSLocalizedString(@"yes", @"yes"), nil];
    [alert setTag:ALERT_CLOSING_GAME];
    [alert show];
    [self.gameLogic pauseGame];
}

#pragma mark UIAlertViewDelegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if((buttonIndex == 1 && alertView.tag == ALERT_CLOSING_GAME) || alertView.tag == ALERT_FINISHING_GAME){
        [self.gameLogic endGame];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
    else if(buttonIndex == 0 && alertView.tag == ALERT_CLOSING_GAME){
        [self.gameLogic resumeGame];
    }
}

#pragma mark GameLogicDelegate methods
-(void)displayGameStepWithQuestion:(NSString*)theQuestion state:(GameStepState)theGameState animated:(BOOL)animated {
    
    [self.progressView setCurrentValue:0];
    [self updateQuestionBackgroundForState:theGameState];
    
    if(animated){
        [self.questionLabel setAlpha:1.0f];
        
        //fade out
        [UIView animateWithDuration:1.0f animations:^{
            [self.keyboardViewController refreshKeyboardWithEnable:NO];
            [self.questionLabel setAlpha:0.0f];
            
        } completion:^(BOOL finished) {
            //Disable keyboard
            [self updateQuestionBackgroundForState:GameStepUnknown];
            [self.questionLabel setText:theQuestion];
            //fade in
            [UIView animateWithDuration:1.0f animations:^{
                [self.questionLabel setAlpha:1.0f];
                
            } completion:^(BOOL finished){
                [self.keyboardViewController refreshKeyboardWithEnable:YES];
                [self.gameLogic newStepIsDisplayed];
            }];
        }];
    }
    else{
        self.questionLabel.backgroundColor = [UIColor clearColor];
        if(theGameState == GameStepFailed){
            self.questionLabel.backgroundColor = [UIColor redColor];
        }
        else if(theGameState == GameStepWon){
            self.questionLabel.backgroundColor = [UIColor greenColor];
        }
        [self.questionLabel setText:theQuestion];
        [self.gameLogic newStepIsDisplayed];
    }
}


-(void)updateQuestionBackgroundForState:(GameStepState)theState{
    if(theState == GameStepFailed){
        self.questionLabel.backgroundColor = [UIColor redColor];
    }
    else if(theState == GameStepWon){
        self.questionLabel.backgroundColor = [UIColor greenColor];
    }
    else{
        self.questionLabel.backgroundColor = [UIColor clearColor];
    }
}

-(void)gameEndedWithScore:(NSInteger)theScore lastState:(GameStepState)theGameState{
    [self updateQuestionBackgroundForState:theGameState];
    NSString * message = [NSString stringWithFormat:@"%@ %ld / 10.",NSLocalizedString(@"gameEndedMessage", @"gameEndedMessage"),(long)theScore];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"gameEndedTitle", @"gameEndedTitle") message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"ok") otherButtonTitles:nil];
    [alert show];
    [alert setTag:ALERT_FINISHING_GAME];
}

-(void)updateGameStepTimeSpentWithSeconds:(int)seconds{
    [self.progressView setCurrentValue:seconds];
}


#pragma mark private methods
-(NSString*)currentNumberResponse{
    NSString * currentQuestionText = self.questionLabel.text;
    NSRange equalRange = [currentQuestionText rangeOfString:@"="];
    return [currentQuestionText substringFromIndex:equalRange.location+2];
}

-(void)addNumberToTheResponseWithNumber:(NSNumber*)theNumber{
    NSString * currentQuestionText = self.questionLabel.text;
    NSRange equalRange = [currentQuestionText rangeOfString:@"="];
    NSString * currentResponseText = [currentQuestionText substringFromIndex:equalRange.location];
    NSString * newResponseText = [NSString stringWithFormat:@"%d",[theNumber intValue]];
    
    //If no answer yet, we replace ? by the number
    if([currentResponseText isEqualToString:@"= ?"]){
        NSString * questionText = [currentQuestionText substringToIndex:equalRange.location+1];
        self.questionLabel.text = [NSString stringWithFormat:@"%@ %@",questionText,newResponseText];
    }
    else{
        //we add the new number
        self.questionLabel.text = [NSString stringWithFormat:@"%@%@",currentQuestionText,newResponseText];
    }
}

#pragma mark CustomKeyboardViewControllerDelegate methods
- (void)customKeyboardViewController:(CustomKeyboardViewController *)keyboardViewController didSelectNumber:(NSNumber *)keyboardNumber{
    //We limit to 5 digits, no answer could overflows this
    if([self currentNumberResponse].length < 5){
        [self addNumberToTheResponseWithNumber:keyboardNumber];
    }
}

- (void)customKeyboardViewControllerDidSelectCancel:(CustomKeyboardViewController *)keyboardViewController{
    NSString * currentQuestionText = self.questionLabel.text;
    NSRange equalRange = [currentQuestionText rangeOfString:@"="];
    NSString * questionText = [currentQuestionText substringToIndex:equalRange.location+1];
    self.questionLabel.text = [NSString stringWithFormat:@"%@ ?",questionText];
}


- (void)customKeyboardViewControllerDidValidate:(CustomKeyboardViewController *)keyboardViewController{
    NSNumber * currentResponse;
    NSString * currentResponseString = [self currentNumberResponse];
    if([currentResponseString isEqualToString:@"?"]){
        currentResponse = nil;
    }
    else{
         currentResponse = [NSNumber numberWithInteger: [[self currentNumberResponse] integerValue]];
    }
    [self.gameLogic validateAnswer:currentResponse];
}
@end
