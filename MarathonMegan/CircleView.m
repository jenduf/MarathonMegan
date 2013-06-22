//
//  TrivieCircleView.m
//  TrivieStory2.0
//
//  Created by J D on 10/30/12.
//  Copyright (c) 2012 Trivie. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if(self)
	{
		[self setFillColor:[UIColor colorForMeganColor:self.tag]];
	}
	
	return self;
}

- (void)setFillColor:(UIColor *)fillColor
{
	_fillColor = fillColor;
	
	[self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect circleRect = CGRectMake(CIRCLE_PADDING, CIRCLE_PADDING, self.width - CIRCLE_SIZE, self.height - CIRCLE_SIZE);
	
	//CGRect strokeRect = CGRectMake(CIRCLE_PADDING, CIRCLE_PADDING, self.width - CIRCLE_SIZE, self.height - CIRCLE_SIZE - SMALL_GAP);
	
	CGContextSaveGState(context);
	CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetLineWidth(context, 8.0);
	CGContextStrokeEllipseInRect(context, circleRect);
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
	CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
	CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
	CGContextFillEllipseInRect(context, circleRect);
	CGContextRestoreGState(context);
}


@end
