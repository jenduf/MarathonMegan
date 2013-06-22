//
//  MenuViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/2/13.
//
//

#import "MenuViewController.h"
#import "GoalsViewController.h"

@interface MenuViewController ()


@end

@implementation MenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	PFQuery *query = [PFQuery queryWithClassName:KEY_USER_CLASS];
	//[query whereKey:KEY_USER_OBJECT equalTo:[PFUser currentUser]];
	//[query whereKey:KEY_MILES_OBJECT greaterThan:[NSNumber numberWithInt:0]];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	 {
		 if(!error)
		 {
			 NSLog(@"Successfully retrieved: %@", objects);
			 
			 self.users = [[NSMutableArray alloc] initWithArray:objects];
		 }
		 else
		 {
			 NSString *errorString = [[error userInfo] objectForKey:@"error"];
			 NSLog(@"Error: %@", errorString);
		 }
	 }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:GOALS_SEGUE])
	{
		//GoalsViewController *gvc = (GoalsViewController *)segue.destinationViewController;
		//[gvc setUsers:self.users];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
