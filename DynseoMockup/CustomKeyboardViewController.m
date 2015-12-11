//
//  CustomKeyboardViewController.m
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 10/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "CustomKeyboardViewController.h"

@interface CustomKeyboardViewController ()
@end


@implementation CustomKeyboardViewController

#pragma mark view life methods
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark actions
- (IBAction)keyboardNumberTouched:(id)sender {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(customKeyboardViewController:didSelectNumber:)]){
        UIButton * touchedButton = (UIButton*)sender;
        [self.delegate customKeyboardViewController:self didSelectNumber:[NSNumber numberWithInt:touchedButton.tag]];
    }
}

- (IBAction)keyboardCancelTouched:(id)sender {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(customKeyboardViewControllerDidSelectCancel:)]){
        [self.delegate customKeyboardViewControllerDidSelectCancel:self];
    }
}

- (IBAction)keyboardValidateTouched:(id)sender {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(customKeyboardViewControllerDidValidate:)]){
        [self.delegate customKeyboardViewControllerDidValidate:self];
    }
}

#pragma mark utils
//Enable or disable all the keyboard buttons depending the parameter
-(void)refreshKeyboardWithEnable:(BOOL)enable{
    for (UIView *subview in ((UIView *)self.view).subviews) {
        if ([subview isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton*)subview;
            [button setUserInteractionEnabled:enable];
        }
    }
}
@end
