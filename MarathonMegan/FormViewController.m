//
//  FormViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#import "FormViewController.h"
#import "JSNotifier.h"
#import "Activity.h"
#import "CalendarDay.h"

@interface FormViewController ()

@end

@implementation FormViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if(self.isEditing)
	{
		self.notesTextView.editable = NO;
		self.notesTextView.backgroundColor = [UIColor clearColor];
		[self.mileageStepper setHidden:YES];
	}
	else
	{
		self.notesTextView.editable = YES;
		self.notesTextView.backgroundColor = [UIColor whiteColor];
		[self.mileageStepper setHidden:NO];
		
	}
	
	self.dateLabel.text = [Utils dateStringForDate:self.calendarDay.date withStyle:NSDateFormatterShortStyle];
	
	if(self.calendarDay.activity)
	{
		self.notesTextView.text = self.calendarDay.activity.notes;
	
		self.mileage.text = (self.calendarDay.activity.miles ? self.calendarDay.activity.miles : @"0.1");
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mileageAdded:(id)sender
{
	UIStepper *stepper = (UIStepper *)sender;
	
	[self.mileage setText:[NSString stringWithFormat:@"%.01f", stepper.value]];
}

- (void)setCalendarDay:(CalendarDay *)calendarDay
{
	_calendarDay = calendarDay;
	_isEditing = (calendarDay.activity != nil);
}

- (IBAction)submitForm:(id)sender
{
	Activity *activity = self.calendarDay.activity;
	
	if(!activity)
	{
		activity = [[Activity alloc] initWithClassName:KEY_ACTIVITY_CLASS];
		[activity setUser:[PFUser currentUser]];
	}
	
	[activity setDateOfRun:self.calendarDay.date];
	[activity setMiles:self.mileage.text];
	[activity setNotes:self.notesTextView.text];

	//	PFUser *user = [PFUser currentUser];
	
	//	PFObject *runner = [PFObject objectWithClassName:KEY_ACTIVITY_CLASS];
	//	[runner setObject:user forKey:KEY_USER_OBJECT];
	//	[runner setObject:self.mileage.text forKey:KEY_MILES_OBJECT];
	//	[runner setObject:self.notesTextView.text forKey:KEY_NOTES_OBJECT];

	[activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	 {
		 if(succeeded)
		 {
			 NSLog(@"Object Uploaded!");
			 [self.notesTextView resignFirstResponder];
			 [self dismissViewControllerAnimated:YES completion:^
			 {
				 NSString *message = [NSString stringWithFormat:@" Your Activity Has Been Saved!"];
				 JSNotifier *notify = [[JSNotifier alloc] initWithTitle:message];
				 [notify showFor:2.0];
			 }];
		 }
		 else
		 {
			 NSString *errorString = [[error userInfo] objectForKey:@"error"];
			 NSLog(@"Error: %@", errorString);
			 [self showErrorWithMessage:errorString];
		 }
	 }];
}

- (IBAction)doneEditing:(id)sender
{
	[self.notesTextView resignFirstResponder];
}

- (IBAction)close:(id)sender
{
	[self.notesTextView resignFirstResponder];
	
	[self dismissViewControllerAnimated:YES completion:^
	{
		
	}];
}

- (void)moveToNextField
{
	
}

- (void)moveToPrevField
{
	
}

#pragma mark -
#pragma mark Keyboard Display Methods
- (void) keyboardWillHide: (NSNotification *) notification
{
	NSDictionary *userInfo = [notification userInfo];
	
	// Get the origin of the keyboard when it's displayed
	NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	
	// Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position
	CGRect keyboardRect = [aValue CGRectValue];
	keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
	
	//CGFloat keyboardTop = keyboardRect.origin.y;
	CGRect newTVFrame = self.formScrollView.bounds;
	newTVFrame.size.height += keyboardRect.size.height;
	
	// get the duration of the animation
	NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	NSTimeInterval animationInterval;
	[animationDuration getValue:&animationInterval];
	
	// animate the resize of the text view's frame in sync with the keyboard's appearance
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:animationInterval];
	
	self.formScrollView.bottom = keyboardRect.origin.y - self.view.bounds.origin.y;
	
	[UIView commitAnimations];
}

- (void) keyboardWillShow: (NSNotification *) notification
{
	
	NSDictionary *userInfo = [notification userInfo];
	
	// Get the origin of the keyboard when it's displayed
	NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	
	// Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position
	CGRect keyboardRect = [aValue CGRectValue];
	keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
	
	CGFloat keyboardTop = keyboardRect.origin.y;
	CGRect newTVFrame = self.formScrollView.bounds;
	newTVFrame.size.height = keyboardTop - self.view.bounds.origin.y;
	
	// get the duration of the animation
	NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	NSTimeInterval animationInterval;
	[animationDuration getValue:&animationInterval];
	
	// animate the resize of the text view's frame in sync with the keyboard's appearance
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:animationInterval];
	
	self.formScrollView.bottom = keyboardRect.origin.y - self.view.bounds.origin.y;
	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark UITextView Delegate Methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{
	
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	self.notesTextView.inputAccessoryView = self.accessoryView;
	
	//self.navigationItem.rightBarButtonItem = self.doneButton;
	
	return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
	
	return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
	
}

@end
