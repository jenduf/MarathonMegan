//
//  CalendarActivity.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/22/13.
//
//

#import <Foundation/Foundation.h>

@interface CalendarActivity : NSObject

@property (nonatomic, strong) NSString *day, *notes, *mileage;
@property (nonatomic, assign) BOOL hasData;
@property (nonatomic, strong) NSDate *activityDate;

@end
