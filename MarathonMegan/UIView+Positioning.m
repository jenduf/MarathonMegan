#import "UIView+Positioning.h"


@implementation UIView (Positioning)

- (void)centerInRect:(CGRect)rect
{
	[self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerVerticallyInRect:(CGRect)rect
{
	[self setCenter:CGPointMake([self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerHorizontallyInRect:(CGRect)rect
{
	[self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0), [self center].y)];
}

- (void)centerInSuperView
{
	[self centerInRect:[[self superview] bounds]];
}

- (void)centerVerticallyInSuperView
{
	[self centerVerticallyInRect:[[self superview] bounds]];
}

- (void)centerHorizontallyInSuperView
{
	[self centerHorizontallyInRect:[[self superview] bounds]];
}

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    // for now, could use screen relative positions.
	NSAssert([self superview] == [view superview], @"views must have the same parent");
  
	[self setCenter:CGPointMake([view center].x,
                              floorf(padding + CGRectGetMaxY([view frame]) + ([self height] / 2)))];
}

- (void)centerHorizontallyBelow:(UIView *)view
{
	[self centerHorizontallyBelow:view padding:0];
}

- (void)centerHorizontallyAbove:(UIView *)view padding:(CGFloat)padding
{
	[self setCenter:CGPointMake(view.center.x, floorf(CGRectGetMinY(view.frame) - (self.height / 2) - padding))];
}

- (void)centerHorizontallyAbove:(UIView *)view
{
	[self centerHorizontallyAbove:view padding:0];
}


- (void)centerVerticallyToTheRightOf:(UIView *)view padding:(CGFloat)padding
{
	[self setCenter:CGPointMake(floorf(padding + CGRectGetMaxX([view frame]) + ([self width] / 2)), [view center].y)];
}

- (void)centerVerticallyToTheRightOf:(UIView *)view
{
	[self centerVerticallyToTheRightOf:view padding:0];
}

- (void)centerVerticallyToTheLeftOf:(UIView *)view padding:(CGFloat)padding
{
	[self setCenter:CGPointMake(floorf(CGRectGetMinX([view frame])) - (self.width / 2) - padding, [view center].y)];
}

- (void)centerVerticallyToTheLeftOf:(UIView *)view
{
	[self centerVerticallyToTheLeftOf:view padding:0];
}

- (void)removeAllSubviewsFromView
{
	for (UIView *subview in self.subviews)
		[subview removeFromSuperview];
}

@end
