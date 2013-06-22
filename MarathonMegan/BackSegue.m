//
//  BackSegue.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/20/13.
//
//

#import "BackSegue.h"

@implementation BackSegue

- (void)perform
{
	UIViewController *source = (UIViewController *)self.sourceViewController;
	UIViewController *destination = (UIViewController *)self.destinationViewController;
	
	//[source.navigationController addSubview:destination.view];
	//[destination.view setRight:0];
	//[destination.view setTop:0];
	
	[UIView transitionWithView:destination.view duration:0.5 options:0 animations:^
	{
		[source.view setLeft:source.view.width];
		[destination.view setLeft:0];
	}
	completion:^(BOOL finished)
	{
		//	[source.view removeFromSuperview];
		//[source.navigationController popViewControllerAnimated:YES];
	}];
}

@end
