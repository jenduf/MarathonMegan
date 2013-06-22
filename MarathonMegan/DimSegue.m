//
//  DimSegue.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/20/13.
//
//

#import "DimSegue.h"

@implementation DimSegue

- (UIView *)findTopMostViewForViewController:(UIViewController *)viewController
{
	UIView *theView = viewController.view;
	UIViewController *parentViewController = viewController.parentViewController;
	while (parentViewController != nil)
	{
		theView = parentViewController.view;
		parentViewController = parentViewController.parentViewController;
	}
	return theView;
}

- (void)perform
{
	UIViewController *source = self.sourceViewController;
	UIViewController *destination = self.destinationViewController;
	
	// Find the views that we will be animating. If the source or destination
	// view controller sits inside a container view controller, then the view
	// to animate will actually be that parent controller's view.
	UIView *sourceView = [self findTopMostViewForViewController:source];
	UIView *destinationView = [self findTopMostViewForViewController:destination];
	
	// Create a black view that covers the entire source view, but set it
	// fully transparent for now. We'll use this to make the source view
	// appear to recede into the background.
	UIView *dimView = [[UIView alloc] initWithFrame:sourceView.frame];
	dimView.opaque = YES;
	dimView.alpha = 0.0f;
	dimView.backgroundColor = [UIColor blackColor];
	[source.view addSubview:dimView];
	
	// Add the destination view to the source view.
	destinationView.frame = sourceView.bounds;
	[sourceView addSubview:destinationView];
	
	// Calculate the endpoint for the destination view. Note: this view is
	// now a subview of the source view and the source view will be moving
	// too, hence the strange coordinates.
	CGPoint destEndPoint = destinationView.center;
	destEndPoint.x += destinationView.bounds.size.width / 2.0f;
	
	// Move the destination view outside the visible area so that it will
	// appear to slide in from the right.
	CGPoint destStartPoint = destinationView.center;
	destStartPoint.x += destinationView.bounds.size.width;
	destinationView.center = destStartPoint;
	
	// Calculate the endpoint for the source view. It will slide off to the
	// left but only moves half the width of the screen, while the destination
	// view slides the entire width of the screen. This gives the animation a
	// nice parallax effect.
	CGPoint sourceEndPoint = sourceView.center;
	sourceEndPoint.x -= sourceView.bounds.size.width / 2.0f;
	
	// Start the animation.
	[UIView animateWithDuration:0.5f
					  delay:0
					options:UIViewAnimationOptionCurveEaseOut
				  animations:^(void)
	 {
		 // Move the views to their endpoints and make the dimView darker.
		 destinationView.center = destEndPoint;
		 sourceView.center = sourceEndPoint;
		 dimView.alpha = 0.5f;
	 }
				  completion: ^(BOOL done)
	 {
		 // The black view is no longer needed now, so remove it.
		 [dimView removeFromSuperview];
		 
		 // Properly present the new screen.
		 [source presentViewController:destination animated:NO completion:nil];
	 }];
}

@end
