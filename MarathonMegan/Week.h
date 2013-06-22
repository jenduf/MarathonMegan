//
//  Week.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/3/13.
//
//

#import <Parse/Parse.h>

@interface Week : PFObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSNumber *milesToRun, *weekNumber;

- (id)initWithPFObject:(PFObject *)object;

@end
