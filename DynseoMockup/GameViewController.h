//
//  GameViewController.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 08/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "GameLogic.h"
#import "CustomKeyboardViewController.h"

@interface GameViewController : UIViewController<UIAlertViewDelegate, GameLogicDelegate, CustomKeyboardViewControllerDelegate>
@property (nonatomic,assign) GameDifficulty gameDifficulty;
@end
