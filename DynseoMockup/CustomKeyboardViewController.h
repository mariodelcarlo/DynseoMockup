//
//  CustomKeyboardViewController.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 10/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomKeyboardViewControllerDelegate;

@interface CustomKeyboardViewController : UIViewController
@property (nonatomic, assign) id <CustomKeyboardViewControllerDelegate> delegate;
-(void)refreshKeyboardWithEnable:(BOOL)enable;
@end

@protocol CustomKeyboardViewControllerDelegate<NSObject>
- (void)customKeyboardViewController:(CustomKeyboardViewController *)keyboardViewController didSelectNumber:(NSNumber *)keyboardNumber;
- (void)customKeyboardViewControllerDidSelectCancel:(CustomKeyboardViewController *)keyboardViewController;
- (void)customKeyboardViewControllerDidValidate:(CustomKeyboardViewController *)keyboardViewController;
@end