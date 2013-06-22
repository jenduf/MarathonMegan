//
//  CalendarDay.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/2/13.
//
//

#import <Foundation/Foundation.h>

@class  Activity;
@interface CalendarDay : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, assign) Activity *activity;

@end
