//
//  CalendarViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/19/13.
//
//

#import "CalendarViewController.h"
#import "CalendarCell.h"
#import "FormViewController.h"
#import "NSDate-Utilities.h"
#import "NSDate+CalendarGrid.h"
#import "NSDate+TKCategory.h"
#import "CalendarActivity.h"
#import "CalendarDay.h"
#import "Activity.h"

@interface CalendarViewController ()

@property (nonatomic, assign) NSInteger numberOfDaysInMonth, numberOfDaysLeftInMonth, currentDay;
@property (nonatomic, assign) NSInteger firstDayOfWeek, firstWeekdayOfWeek;
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) NSMutableDictionary *dayDictionary;
@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation CalendarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	/*self.calendarView = [[TSQCalendarView alloc] init];
	self.calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	self.calendarView.rowCellClass = [CalendarRowCell class];
	self.calendarView.firstDate = [NSDate date];
	self.calendarView.lastDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 * 5];
	self.calendarView.backgroundColor = [UIColor whiteColor];
	self.calendarView.pagingEnabled = YES;
	CGFloat onePixel = 1.0 / [UIScreen mainScreen].scale;
	self.calendarView.contentInset = UIEdgeInsetsMake(0.0f, onePixel, 0.0f, onePixel);
	[self.view addSubview:self.calendarView];
	self.calendarView.frame = CGRectInset(self.view.frame, 5, 5);
	self.calendarView.delegate = self;
	[self.calendarView centerInSuperView];*/
	
	self.dayDictionary = [[NSMutableDictionary alloc] init];
	self.activities = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	PFQuery *query = [PFQuery queryWithClassName:KEY_ACTIVITY_CLASS];
	[query whereKey:KEY_USER_OBJECT equalTo:[PFUser currentUser]];
	//[query whereKey:KEY_MILES_OBJECT greaterThan:[NSNumber numberWithInt:0]];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	 {
		 if(!error)
		 {
			 NSLog(@"Successfully retrieved: %@", objects);
			 
			 for(PFObject *object in objects)
			 {
				 Activity *activity = [[Activity alloc] initWithPFObject:object];
				 
				 NSInteger day = [activity.dateOfRun day];
				 NSInteger weekday = [activity.dateOfRun weekday];
				 NSLog(@"Run Date: %@, Day: %i, Weekday: %i", activity.dateOfRun, day, weekday);
				 
				 // NSString *dayString = [NSString stringWithFormat:@"%i", day];
				 
				 NSString *dateString = [Utils dateStringForDate:activity.dateOfRun withStyle:NSDateFormatterShortStyle];
				 
				 [self.dayDictionary setObject:activity forKey:dateString];
			 }
			 
			 //self.activities = [[NSMutableArray alloc] initWithArray:objects];
			 [self createCalendarForDate:[NSDate date]];
		 }
		 else
		 {
			 NSString *errorString = [[error userInfo] objectForKey:@"error"];
			 NSLog(@"Error: %@", errorString);
		 }
	 }];
}

- (IBAction)changeMonth:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	
	switch(btn.tag)
	{
		case 1:
		{
			[self createCalendarForDate:[self.currentDate previousMonth]];
		}
			break;
			
		case 2:
		{
			[self createCalendarForDate:[self.currentDate nextMonth]];
		}
			break;
	}
}

- (void)createCalendarForDate:(NSDate *)date
{
	self.currentDate = date;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSRange monthRange = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
	NSDateComponents *dayOfWeekComponent = [gregorian components:NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit fromDate:date];
	
	self.calendarMonth.text = [[date monthString] uppercaseString];
	
	self.numberOfDaysInMonth = monthRange.length;
	
	self.numberOfDaysLeftInMonth = monthRange.length - [dayOfWeekComponent day];
	
	self.currentDay = [dayOfWeekComponent day];
	
	NSDate *firstDayDate = [self.currentDate firstOfMonth];
	
	self.firstDayOfWeek = [firstDayDate day];//[dayOfWeekComponent day];
	self.firstWeekdayOfWeek = [firstDayDate weekday];
	//NSInteger firstWeekdayOfWeek = [gregorian dateByAddingComponents:firstDayComponents toDate:<#(NSDate *)#> options:<#(NSUInteger)#>]
	
	NSLog(@"Month Range: %i, Day: %i, Days Left: %i, First Weekday: %i, First Day: %i, %@", self.numberOfDaysInMonth, self.currentDay, self.numberOfDaysLeftInMonth, self.firstWeekdayOfWeek, self.firstDayOfWeek, dayOfWeekComponent.date);
	
	[self.activities removeAllObjects];
	
	NSInteger totalDays = monthRange.length;
	
	for(int i = (-self.firstWeekdayOfWeek + 1); i < totalDays; i++)
	{
		NSDate *nextDate = [firstDayDate dateByAddingDays:i];
		CalendarDay *day = [[CalendarDay alloc] init];
		
		if(i >= 0)
		{
			NSString *dayString = [NSString stringWithFormat:@"%i", i + 1];
			
			NSString *dateString = [Utils dateStringForDate:nextDate withStyle:NSDateFormatterShortStyle];
			
			Activity *activity = (Activity *)[self.dayDictionary objectForKey:dateString];
			
			day.day = dayString;
			day.date = nextDate;
			day.activity = activity;
		}
		
		[self.activities addObject:day];
	}
	
	[self.calendarCollectionView reloadData];
}

- (NSString *)reuseIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CalendarDay *calendarDay = self.activities[indexPath.row];

	if(!calendarDay.date)
		return DISABLED_DAY_CELL_IDENTIFIER;
	else if([calendarDay.date isEqualToDateIgnoringTime:[NSDate date]])
		return TODAY_CELL_IDENTIFIER;
	else if(calendarDay.activity)
		return DAY_SELECTED_CELL_IDENTIFIER;
	
	return DAY_CELL_IDENTIFIER;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
	return self.activities.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *reuseID = [self reuseIdentifierForRowAtIndexPath:indexPath];
	
	CalendarDay *calendarDay = self.activities[indexPath.row];
	
	CalendarCell *cell = [cv dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
	
	//NSInteger day =  ((indexPath.row + 1) - self.firstWeekdayOfWeek);
	
	cell.dateLabel.text = calendarDay.day;
	
	return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CALENDAR_HEADER_CELL_IDENTIFIER forIndexPath:indexPath];
	
	return headerView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	CalendarDay *calendarDay = self.activities[indexPath.row];
	
	FormViewController *fvc = (FormViewController *)[self.storyboard instantiateViewControllerWithIdentifier:vcFormView];
	[fvc setCalendarDay:calendarDay];
	
	[self presentViewController:fvc animated:YES completion:^
	 {
		 
	 }];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
