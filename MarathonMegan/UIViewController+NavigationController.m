//
//  UIViewController+BaseViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/9/13.
//
//

#import "UIViewController+NavigationController.h"
#import "BaseViewController.h"

@implementation UIViewController (NavigationController)

- (NavigationViewController *)navigationViewController
{
	return [BaseViewController containerControllerKindOfClass:[NavigationViewController class] forViewController:self];
}

@end
