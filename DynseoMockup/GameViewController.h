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

//The controler displaying the game: arithmetic question, keyboard, timer
@interface GameViewController : UIViewController<UIAlertViewDelegate, GameLogicDelegate, CustomKeyboardViewControllerDelegate>
//The game difficulty choosen for the game
@property (nonatomic,assign) GameDifficulty gameDifficulty;
@end
