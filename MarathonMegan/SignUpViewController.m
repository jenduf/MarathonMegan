//
//  SignUpViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/19/13.
//
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@property (nonatomic, strong) UITextField *activeTextField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *registerFields;
@property (weak, nonatomic) IBOutlet UITextField *registerName, *registerEmail, *registerPassword, *registerPassword1;

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)submit:(id)sender
{
	if([self checkFields] == YES)
	{
		PFUser *user = [PFUser user];
		user.username = self.registerName.text;
		user.password = self.registerPassword.text;
		user.email = self.registerEmail.text;
		
		
		
		[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
		 {
			 if(succeeded)
			 {
				 NSLog(@"Registered!");
				 [self performSegueWithIdentifier:SIGN_UP_SEGUE sender:nil];
			 }
			 else
			 {
				 NSLog(@"Registration failed: %@", error.localizedDescription);
				 NSString *errorString = [[error userInfo] objectForKey:@"error"];
				 [self showErrorWithMessage:errorString];
			 }
		 }];
	}
}



- (BOOL)checkFields
{
	BOOL informationComplete = YES;
	
	for(UITextField *tf in self.registerFields)
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
