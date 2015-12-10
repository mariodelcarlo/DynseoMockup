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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)keyboardNumberTouched:(id)sender {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(customKeyboardViewController:didSelectNumber:)]){
        UIButton * touchedButton = (UIButton*)sender;
        [self.delegate customKeyboardViewController:self didSelectNumber:[NSNumber numberWithInt:touchedButton.tag]];
    }
}

#pragma mark actions
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


@end
