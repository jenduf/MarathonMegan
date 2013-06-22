//
//  BaseViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#import "BaseViewController.h"
#import "GoalsViewController.h"
#import "CalendarViewController.h"
#import "RunViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	/*REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home" subtitle:@"Return to Home Screen" image:[UIImage imageNamed:@"Icon_Home"] highlightedImage:nil action:^(REMenuItem *item)
					    {
						    NSLog(@"Item Selected: %@", item);
						    
					    }];
	
	REMenuItem *goalsItem = [[REMenuItem alloc] initWithTitle:@"Goals" subtitle:@"Go to Goals" image:[UIImage imageNamed:@"Icon_Activity"] highlightedImage:nil action:^(REMenuItem *item)
						   {
							   GoalsViewController *goalsVC = [self.storyboard instantiateViewControllerWithIdentifier:vcGoalsView];
							   [self.navigationController pushViewController:goalsVC animated:YES];
							   
						   }];
	
	REMenuItem *calendarItem = [[REMenuItem alloc] initWithTitle:@"Calendar" subtitle:@"Go to Calendar" image:[UIImage imageNamed:@"Icon_Profile"] highlightedImage:nil action:^(REMenuItem *item)
						   {
							   GoalsViewController *calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:vcCalendarView];
							   [self.navigationController pushViewController:calendarVC animated:YES];
							   
						   }];
	
	REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"Run" subtitle:@"Go to Run" image:[UIImage imageNamed:@"Icon_Explore"] highlightedImage:nil action:^(REMenuItem *item)
						   {
							   RunViewController *runVC = [self.storyboard instantiateViewControllerWithIdentifier:vcRunView];
							   [self.navigationController pushViewController:runVC animated:YES];
							   
						   }];
	
	_menu = [[REMenu alloc] initWithItems:@[homeItem, goalsItem, calendarItem, activityItem]];*/
}

- (IBAction)goBack:(UIStoryboardSegue *)segue
{
	//[self performSegueWithIdentifier:BACK_SEGUE sender:self];
}

- (IBAction)showMenu:(id)sender
{
	[self.navigationViewController showMenu:sender];
}

- (IBAction)logOut:(id)sender
{
	[PFUser logOut];
	
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)showErrorWithMessage:(NSString *)message
{
	
	UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
	[errorAlertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (id)containerControllerKindOfClass:(Class)containerControllerClass forViewController:(UIViewController *)viewController
{
	BaseViewController *baseViewController = (BaseViewController *)viewController;//objc_getAssociatedObject(viewController, s_containerContentKey);
	
	NSAssert((![baseViewController isKindOfClass:containerControllerClass]), @"Cannot have navigation controller as child class and parent class!");
	
	if ([baseViewController.containerController isKindOfClass:containerControllerClass])
	{
		return baseViewController.containerController;
	}
	else
	{
		//NSLog(@"Container Class %@, Base Class: %@, VC Class: %@", NSStringFromClass(containerControllerClass), NSStringFromClass([baseViewController.containerController class]), NSStringFromClass([viewController class]));
		
		return nil;
	}
	
	
}

@end
