//
//  DifficultyViewController.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 09/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "DifficultyViewController.h"
#import "GameLogic.h"
#import "GameViewController.h"

@interface DifficultyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *easyButton;
@property (weak, nonatomic) IBOutlet UIButton *normalButton;
@property (weak, nonatomic) IBOutlet UIButton *hardButton;
@end

@implementation DifficultyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.titleLabel.text = NSLocalizedString(@"difficultyTitle", @"");
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameDifficulty difficulty = GameDifficultyEasy;
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender == self.normalButton){
        difficulty = GameDifficultyNormal;
    }
    else if(sender == self.hardButton){
        difficulty = GameDifficultyHard;
    }
    
    UIViewController * destinationController = [segue destinationViewController];
    if([destinationController isKindOfClass:[GameViewController class]]){
        GameViewController *gv = (GameViewController*) destinationController;
        gv.gameDifficulty = difficulty;
    }
}


@end
