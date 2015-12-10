//
//  HomeViewController.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@end

@implementation HomeViewController

#pragma mark view life methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //Hide navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    //Set texts
    [self.welcomeLabel setText:NSLocalizedString(@"welcomeLabelTitle", @"")];
    [self.playButton setTitle:NSLocalizedString(@"playButtonTitle", @"") forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
