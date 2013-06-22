//
//  LoginViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, assign) LoginState loginState;
@property (nonatomic, strong) UITextField *activeTextField;
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *loginFields;
@property (weak, nonatomic) IBOutlet UITextField *loginUser;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;

@property (nonatomic, strong) UIGestureRecognizer *tapRecognizer;

- (IBAction)closeKeyboard:(UIGestureRecognizer *)recognizer;

@end

@implementation LoginViewController

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
	
	PFUser *user = [PFUser currentUser];
	
	//[PFUser logOut];
	
	if(user.isAuthenticated)
	{
		[self performSegueWithIdentifier:LOGIN_SEGUE sender:nil];
	}
	//else
	//{
	//	UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:vcLoginView];
	//	[self.navigationController pushViewController:controller animated:YES];
	//}
	
	//self.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsFacebook | PFLogInFieldsTwitter;
	//self.logInView.signUpButton.hidden = YES;
	//self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender
{
	[self.activeTextField resignFirstResponder];
	
	if([self checkFields] == YES)
	{
		[PFUser logInWithUsernameInBackground:self.loginUser.text password:self.loginPassword.text block:^(PFUser *user, NSError *error)
		{
			if(user)
			{
				NSLog(@"Logged in!");
				
				[self performSegueWithIdentifier:LOGIN_SEGUE sender:nil];
			}
			else
			{
				NSLog(@"Login failed %@", error.localizedDescription);
				NSString *errorString = [[error userInfo] objectForKey:@"error"];
				[self showErrorWithMessage:errorString];
			}
		}];
	}
}

- (void)closeKeyboard:(UIGestureRecognizer *)recognizer
{
	//	[self.view removeGestureRecognizer:recognizer];
	
	[self.activeTextField resignFirstResponder];
}

#pragma mark -
#pragma mark Keyboard Display Methods
- (void) keyboardWillHide: (NSNotification *) notification
{
	// return to previous text view size
	double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	//CGRect frameRect = [(NSValue*)[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	
	[UIView animateWithDuration:duration animations:^
	{
		[self.loginScrollView setContentOffset:CGPointMake(0, -20)];
	}];
}

- (void) keyboardWillShow: (NSNotification *) notification
{
	// Retrieve the keyboard bounds via the notification userInfo dictionary
	double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	//CGRect frameRect = [(NSValue*)[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	
	[UIView animateWithDuration:duration animations:^
	 {
		 [self.loginScrollView setContentOffset:CGPointMake(0, 20)];
	 }];
	
	//[self.loginScrollView addGestureRecognizer:self.tapRecognizer];
}

- (BOOL)checkFields
{
	BOOL informationComplete = YES;
	
	for(UITextField *tf in self.loginFields)
	{
		if(tf.text.length == 0)
		{
			informationComplete = NO;
			break;
		}
	}
	
	// Display an alert if a field wasn't completed
	if (!informationComplete)
	{
		[[[UIAlertView alloc] initWithTitle:@"Missing Information"
							   message:@"Make sure you fill out all of the information!"
							  delegate:nil
					   cancelButtonTitle:@"ok"
					   otherButtonTitles:nil] show];
	}
	
	return informationComplete;
}

#pragma mark -
#pragma mark Text Field Delegates

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
	[textField resignFirstResponder];
	
	[self submit:textField];
	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[textField resignFirstResponder];
	self.activeTextField = nil;
}

@end
