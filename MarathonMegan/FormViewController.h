//
//  FormViewController.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#import <UIKit/UIKit.h>

@class CalendarDay;
@interface FormViewController : BaseViewController
<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mileage;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (nonatomic, weak) IBOutlet UIScrollView *formScrollView;
@property (strong, nonatomic) IBOutlet UIToolbar *accessoryView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, weak) IBOutlet UIStepper *mileageStepper;
@property (nonatomic, strong) CalendarDay *calendarDay;

- (IBAction)mileageAdded:(id)sender;
- (IBAction)submitForm:(id)sender;
- (IBAction)moveToPrevField;
- (IBAction)moveToNextField;
- (IBAction)doneEditing:(id)sender;
- (IBAction)close:(id)sender;

@end
