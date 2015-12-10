//
//  ProgressView.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 10/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgressView : UIView {
	float minValue, maxValue;
	float currentValue;
	UIColor *lineColor, *progressRemainingColor, *progressColor;
}

@property (nonatomic) float minValue, maxValue, currentValue;
@property (nonatomic, retain) UIColor *lineColor, *progressRemainingColor, *progressColor;

-(void)refresh;

@end
