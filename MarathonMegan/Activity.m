//
//  Activity.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/2/13.
//
//

#import "Activity.h"

@implementation Activity

- (id)initWithPFObject:(PFObject *)object
{
	self = [super initWithClassName:KEY_ACTIVITY_CLASS];
	
	if(self)
	{
		self.dateOfRun = [object objectForKey:KEY_DATE_OF_RUN_OBJECT];
		self.miles = [object objectForKey:KEY_MILES_OBJECT];
		self.notes = [object objectForKey:KEY_NOTES_OBJECT];
		self.user = [object objectForKey:KEY_USER_OBJECT];
	}
	
	return self;
}

- (void)setMiles:(NSString *)miles
{
	_miles = miles;
	
	if(miles)
		[self setObject:miles forKey:KEY_MILES_OBJECT];
}

- (void)setNotes:(NSString *)notes
{
	_notes = notes;
	
	if(notes)
		[self setObject:notes forKey:KEY_NOTES_OBJECT];
}

- (void)setUser:(PFUser *)user
{
	_user = user;
	
	if(user)
		[self setObject:user forKey:KEY_USER_OBJECT];
}

- (void)setDateOfRun:(NSDate *)dateOfRun
{
	_dateOfRun = dateOfRun;
	
	if(dateOfRun)
		[self setObject:dateOfRun forKey:KEY_DATE_OF_RUN_OBJECT];
}

@end
