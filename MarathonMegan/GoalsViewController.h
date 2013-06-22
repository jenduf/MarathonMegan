//
//  LoginSelectViewController.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/19/13.
//
//

#import "BaseViewController.h"

@interface GoalsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *yourDailyActivity, *yourWeeklyActivity;
@property (weak, nonatomic) IBOutlet UILabel *friendDailyActivity, *friendWeeklyActivity;
@property (weak, nonatomic) IBOutlet UILabel *weekTitle;
@property (weak, nonatomic) IBOutlet UILabel *weekInfo;
@property (weak, nonatomic) IBOutlet UILabel *daysLeft;

@end
