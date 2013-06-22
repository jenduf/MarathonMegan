//
//  GlossyButton.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/23/13.
//
//

#import "GlossyButton.h"

@implementation GlossyButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if(self)
	{
		self.buttonBackgroundColor = self.backgroundColor;
		self.buttonTextColor = self.titleLabel.textColor;
		
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (id)initWithBackgroundColor:(UIColor *)backgroundColor andTextColor:(UIColor *)textColor
{
	self = [super initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
	
	if(self)
	{
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		
		self.buttonBackgroundColor = backgroundColor;
		self.buttonTextColor = textColor;
		
		[self.titleLabel setFont:[UIFont marketingFontOfSize:FONT_SIZE_BUTTON]];
	}
	
	return self;
}

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor
{
	_buttonBackgroundColor = buttonBackgroundColor;
	
	[self setNeedsDisplay];
}

- (void)setButtonTextColor:(UIColor *)buttonTextColor
{
	_buttonTextColor = buttonTextColor;
	
	[self setTitleColor:buttonTextColor forState:UIControlStateNormal];
	[self.titleLabel setShadowColor:[UIColor blackColor]];
	[self.titleLabel setShadowOffset:CGSizeMake(0, 1)];
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
	[super setSelected:selected];
	
	[self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGFloat hue = 0.0, sat = 0.0, bright = 0.0, alpha = 0.0;
	
	BOOL converted = [self.buttonBackgroundColor getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
	
	NSLog(@"H: %f, S: %f, B: %f, A: %f, Converted: %i", hue, sat, bright, alpha, converted);
	
	
	if(self.state == UIControlStateHighlighted)
	{
		bright -= 0.10;
	}
	
	CGColorRef highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4].CGColor;
	CGColorRef highlightStop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
	CGColorRef shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5].CGColor;
	
	CGColorRef outerTop = [UIColor colorWithHue:hue saturation:sat brightness:1.0 * bright alpha:1.0].CGColor;
	CGColorRef outerBottom = [UIColor colorWithHue:hue saturation:sat brightness:0.8 * bright alpha:1.0].CGColor;
	CGColorRef outerStroke = [UIColor colorWithHue:hue saturation:sat brightness:0.7 * bright alpha:1.0].CGColor;
	CGColorRef innerStroke = [UIColor colorWithHue:hue saturation:sat brightness:0.8 * bright alpha:1.0].CGColor;
	CGColorRef innerTop = [UIColor colorWithHue:hue saturation:sat brightness:0.9 * bright alpha:1.0].CGColor;
	CGColorRef innerBottom = [UIColor colorWithHue:hue saturation:sat brightness:0.7 * bright alpha:1.0].CGColor;
	
	CGFloat outerMargin = 5.0f;
	CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
	CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
	
	CGFloat innerMargin = 3.0f;
	CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
	CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 6.0);
	
	CGFloat highlightMargin = 2.0f;
	CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
	CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 6.0);
	
	// draw shadow
	if(self.state != UIControlStateHighlighted)
	{
		CGContextSaveGState(context);
		CGContextSetFillColorWithColor(context, outerTop);
		CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
		CGContextAddPath(context, outerPath);
		CGContextFillPath(context);
		CGContextRestoreGState(context);
	}
	
	CGColorRef outerTopColor = (self.state == UIControlStateHighlighted ? outerBottom : outerTop);
	CGColorRef outerBottomColor = (self.state == UIControlStateHighlighted ? outerTop : outerBottom);
	
	CGColorRef innerTopColor = (self.state == UIControlStateHighlighted ? innerBottom : innerTop);
	CGColorRef innerBottomColor = (self.state == UIControlStateHighlighted ? innerTop : innerBottom);
	
	// draw gradient for outer path
	CGContextSaveGState(context);
	CGContextAddPath(context, outerPath);
	CGContextClip(context);
	drawGlossAndGradient(context, outerRect, outerTopColor, outerBottomColor);
	CGContextRestoreGState(context);
	
	// draw gradient for inner path
	CGContextSaveGState(context);
	CGContextAddPath(context, innerPath);
	CGContextClip(context);
	drawGlossAndGradient(context, innerRect, innerTopColor, innerBottomColor);
	CGContextRestoreGState(context);
	
	// draw highlight (if not selected)
	if(self.state != UIControlStateHighlighted)
	{
		CGContextSaveGState(context);
		CGContextSetLineWidth(context, 4.0);
		CGContextAddPath(context, outerPath);
		CGContextAddPath(context, highlightPath);
		CGContextEOClip(context);
		drawLinearGradient(context, outerRect, highlightStart, highlightStop);
		CGContextRestoreGState(context);
	}
	
	// stroke outer path
	CGContextSaveGState(context);
	CGContextSetLineWidth(context, 2.0);
	CGContextSetStrokeColorWithColor(context, outerStroke);
	CGContextAddPath(context, outerPath);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
	
	// stroke inner path
	CGContextSaveGState(context);
	CGContextSetLineWidth(context, 2.0);
	CGContextSetStrokeColorWithColor(context, innerStroke);
	CGContextAddPath(context, innerPath);
	CGContextClip(context);
	CGContextAddPath(context, innerPath);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
	
	CFRelease(outerPath);
	CFRelease(innerPath);
	CFRelease(highlightPath);
}

@end
