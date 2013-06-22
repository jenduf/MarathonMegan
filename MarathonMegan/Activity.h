//
//  Activity.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/2/13.
//
//

#import <Parse/Parse.h>
#import "User.h"

@interface Activity : PFObject

@property (nonatomic, strong) NSString *miles, *notes;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) NSDate *dateOfRun;

- (id)initWithPFObject:(PFObject *)object;

@end
