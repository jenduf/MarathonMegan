//
//  CalendarViewController.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/19/13.
//
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : BaseViewController
<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *calendarMonth;

- (IBAction)changeMonth:(id)sender;


@end
