//
//  MainViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#import "MainViewController.h"
#import "ActivityCell.h"

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, weak) IBOutlet UITableView *activityTableView;

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//PFUser *user = [PFUser currentUser];
	PFQuery *query = [PFQuery queryWithClassName:KEY_ACTIVITY_CLASS];
	//[query whereKey:KEY_USER_OBJECT equalTo:[PFUser currentUser]];
	//[query whereKey:KEY_MILES_OBJECT greaterThan:[NSNumber numberWithInt:0]];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	 {
		 if(!error)
		 {
			 NSLog(@"Successfully retrieved: %@", objects);
			 
			 self.activities = [[NSMutableArray alloc] initWithArray:objects];
			 [self.activityTableView reloadData];
		 }
		 else
		 {
			 NSString *errorString = [[error userInfo] objectForKey:@"error"];
			 NSLog(@"Error: %@", errorString);
		 }
	 }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewEntry:(id)sender
{
	[self performSegueWithIdentifier:ENTRY_SEGUE sender:nil];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:ACTIVITY_CELL_IDENTIFIER];
	
	PFObject *activity = self.activities[indexPath.row];
	PFUser *user = [activity objectForKey:KEY_USER_OBJECT];
	
	[user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error)
	{
		cell.userName.text = [NSString stringWithFormat:@"%@", user.username];//[activity objectForKey:@"Miles"]];
	}];
	
	cell.dateModified.text = [NSString stringWithFormat:@"%@", activity.updatedAt];
	
	
	cell.notes.text = [NSString stringWithFormat:@"%@", [activity objectForKey:KEY_NOTES_OBJECT]];
	
	return cell;
}

@end
