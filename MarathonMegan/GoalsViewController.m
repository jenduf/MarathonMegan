//
//  LoginSelectViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/19/13.
//
//

#import "GoalsViewController.h"
#import "MainPanelViewController.h"
#import "Week.h"
#import "Activity.h"

@interface GoalsViewController ()

@property (nonatomic, assign) CGFloat myTotalMiles, otherTotalMiles, myDailyMiles, otherDailyMiles;
@property (nonatomic, assign) NSInteger myTotalDays, otherTotalDays;

@end

@implementation GoalsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.daysLeft setFont:[UIFont funFontOfSize:FONT_SIZE_DAYS_LEFT]];
	
	PFQuery *query = [PFQuery queryWithClassName:KEY_WEEKS_CLASS];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if(!error)
		{
			NSLog(@"Successfully retrieved: %@", objects);
			
			for(PFObject *object in objects)
			{
				Week *week = [[Week alloc] initWithPFObject:object];
				if([week.startDate isThisWeek])
				{
					self.weekTitle.text = [NSString stringWithFormat:@"Welcome to Week %@", week.weekNumber];
					self.weekInfo.text = [NSString stringWithFormat:@"Week %@ is a %@-mile week", week.weekNumber, week.milesToRun];
				}
				
				[self updateRunnerActivity];
				
			}
		}
		else
		{
			NSString *errorString = [[error userInfo] objectForKey:@"error"];
			NSLog(@"Error: %@", errorString);
		}
	}];
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMonth:4];
	[components setDay:28];
	[components setYear:2013];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *runDate = [gregorian dateFromComponents:components];
	NSDate *today = [NSDate date];
	//NSTimeInterval interval = [runDate timeIntervalSinceDate:today];
	//NSDateComponents *dateComponents = [gregorian components:NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today toDate:runDate options:0];
	
	//NSInteger month = [dateComponents month];
	NSInteger days = [today daysBeforeDate:runDate];//[dateComponents day];
	self.daysLeft.text = [NSString stringWithFormat:@"%i", days];
	
	//	[self.daysLeft centerVerticallyInSuperView];
}

- (void)updateRunnerActivity
{
	PFQuery *query = [PFQuery queryWithClassName:KEY_ACTIVITY_CLASS];
	//[query whereKey:KEY_USER_OBJECT equalTo:[PFUser currentUser]];
	//[query whereKey:KEY_MILES_OBJECT greaterThan:[NSNumber numberWithInt:0]];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	 {
		 if(!error)
		 {
			 NSLog(@"Successfully retrieved: %@", objects);
			 
			 for(PFObject *object in objects)
			 {
				 Activity *activity = [[Activity alloc] initWithPFObject:object];
			
				 NSDate *activityDate = activity.dateOfRun;
				 
				 if([activityDate isToday])
				 {
					 if(activity.user == [PFUser currentUser])
						 self.myDailyMiles +=  [activity.miles floatValue];
					 else
						 self.otherDailyMiles += [activity.miles floatValue];
				 }
				 
				 if([activityDate isThisWeek])
				 {
					  if(activity.user == [PFUser currentUser])
					  {
						  self.myTotalDays++;
						  self.myTotalMiles += [activity.miles floatValue];
					  }
					 else
					 {
						 self.otherTotalDays++;
						 self.otherTotalMiles += [activity.miles floatValue];
					 }
				 }
				 
				 NSInteger day = [activityDate day];
				 NSInteger weekday = [activityDate weekday];
				 NSLog(@"Run Date: %@, Day: %i, Weekday: %i", activityDate, day, weekday);
				 
				 // NSString *dayString = [NSString stringWithFormat:@"%i", day];
			 }
			 
			 //self.activities = [[NSMutableArray alloc] initWithArray:objects];
			 [self updateData];
		 }
		 else
		 {
			 NSString *errorString = [[error userInfo] objectForKey:@"error"];
			 NSLog(@"Error: %@", errorString);
		 }
	 }];
}

- (void)updateData
{
	//for(PFUser *user in self.users)
	//{
	//	NSLog(@"User name: %@", user.username);
	//}
	
	if(self.myDailyMiles == 0)
	{
		self.yourDailyActivity.text = @"You have not run today.";
	}
	else
	{
		self.yourDailyActivity.text = [NSString stringWithFormat:@"You have run %.02f miles today.", self.myDailyMiles];
	}
	
	if(self.otherDailyMiles == 0)
	{
		self.friendDailyActivity.text = @"Megan R. has not run today.";
	}
	else
	{
		self.friendDailyActivity.text = [NSString stringWithFormat:@"Megan R. has run %.02f miles today.", self.otherDailyMiles];
	}
	
	if(self.myTotalMiles == 0)
	{
		self.yourWeeklyActivity.text = @"You have not run this week.";
	}
	else
	{
		self.yourWeeklyActivity.text = [NSString stringWithFormat:@"You have run %i days this week, %.02f miles total", self.myTotalDays, self.myTotalMiles];
	}
	
	if(self.otherTotalMiles == 0)
	{
		self.friendWeeklyActivity.text = @"Megan R. has not run this week.";
	}
	else
	{
		self.friendWeeklyActivity.text = [NSString stringWithFormat:@"Megan R. has run %i days this week, %.02f miles total", self.otherTotalDays, self.otherTotalMiles];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
