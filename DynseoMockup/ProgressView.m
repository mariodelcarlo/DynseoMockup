//
//  ProgressView.h
//  DynseoMockup
//
//  Created by Marie-Odile Del Carlo on 10/12/2015.
//  Copyright © 2015 Marie-Odile Del Carlo. All rights reserved.
//

#import "ProgressView.h"


@implementation ProgressView

@synthesize  minValue, maxValue, currentValue;
@synthesize lineColor, progressRemainingColor, progressColor;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		minValue = 0;
		maxValue = 1;
		currentValue = 0;
		self.backgroundColor = [UIColor clearColor];
		lineColor = [UIColor whiteColor];
		progressColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] ;
		progressRemainingColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 2);
	CGContextSetStrokeColorWithColor(context,[lineColor CGColor]);
	
	CGContextSetFillColorWithColor(context, [progressColor CGColor]);
	float sizeRecBlanc = (currentValue/(maxValue - minValue)) * (rect.size.width);
	CGRect rectBlanc = CGRectMake(0, 0, sizeRecBlanc, rect.size.height);
	CGContextFillRect(context, rectBlanc);
	
	CGContextSetFillColorWithColor(context, [progressRemainingColor CGColor]);
	float sizeRectNoir =  rect.size.width - rectBlanc.size.width;
	float posDebutRectNoir = minValue + rectBlanc.size.width;
	CGRect rectNoir = CGRectMake(posDebutRectNoir, 0, sizeRectNoir, rect.size.height);
	CGContextFillRect(context, rectNoir);
}


-(void)setCurrentValue:(float)newValue{
	currentValue = newValue;
    [self refresh];
}

-(void)refresh{
	[self setNeedsDisplay];
}


@end
