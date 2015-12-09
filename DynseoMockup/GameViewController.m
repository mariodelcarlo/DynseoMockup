//
//  GameViewController.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "GameViewController.h"

#define ALERT_CLOSING_GAME 123
#define ALERT_FINISHING_GAME 456

@interface GameViewController ()
@property (nonatomic, retain)GameLogic *gameLogic;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@end

@implementation GameViewController

#pragma mark view life methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameLogic = [[GameLogic alloc] init];
    self.gameLogic.gameDelegate = self;
    [self.gameLogic startWithDifficulty:self.gameDifficulty];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
-(void)displayGameStepWithQuestion:(NSString*)theQuestion{
    [CATransaction begin];
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [CATransaction setCompletionBlock:^{
        [self.gameLogic newStepIsDisplayed];
    }];
    [self.questionLabel.layer addAnimation:animation forKey:@"changeTextTransition"];
    [self.questionLabel setText:theQuestion];
    [CATransaction commit];
}

-(void)gameEndedWithScore:(NSInteger)theScore{
    NSString * message = [NSString stringWithFormat:@"%@ %ld / 10.",NSLocalizedString(@"gameEndedMessage", @"gameEndedMessage"),(long)theScore];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"gameEndedTitle", @"gameEndedTitle") message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"ok") otherButtonTitles:nil];
    [alert show];
    [alert setTag:ALERT_FINISHING_GAME];
}



@end
