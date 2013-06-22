//
//  Week.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/3/13.
//
//

#import "Week.h"

@implementation Week

- (id)initWithPFObject:(PFObject *)object
{
	self = [super init];
	
	if(self)
	{
		self.startDate = [object objectForKey:KEY_START_DATE_OBJECT];
		self.milesToRun = [object objectForKey:KEY_MILES_TO_RUN_OBJECT];
		self.weekNumber = [object objectForKey:KEY_WEEK_NUMBER_OBJECT];
	}
	
	return self;
}


@end
