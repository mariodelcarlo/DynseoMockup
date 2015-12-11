//
//  CustomKeyboardViewController.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 10/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomKeyboardViewControllerDelegate;

//A custom digital keayboard displayed on the screen
//Contains digit from 0 to 9, a button to cancel all digits entered and a button to validate
@interface CustomKeyboardViewController : UIViewController
@property (nonatomic, assign) id <CustomKeyboardViewControllerDelegate> delegate;
-(void)refreshKeyboardWithEnable:(BOOL)enable;
@end

@protocol CustomKeyboardViewControllerDelegate<NSObject>
//A number has been entered via the custom keyboard
- (void)customKeyboardViewController:(CustomKeyboardViewController *)keyboardViewController didSelectNumber:(NSNumber *)keyboardNumber;
//The cancel button has been touched via the custom keyboard
- (void)customKeyboardViewControllerDidSelectCancel:(CustomKeyboardViewController *)keyboardViewController;
//The validate button has been touched via the custom keyboard
- (void)customKeyboardViewControllerDidValidate:(CustomKeyboardViewController *)keyboardViewController;
@end