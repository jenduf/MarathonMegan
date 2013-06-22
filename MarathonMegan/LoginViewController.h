//
//  LoginViewController.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#import <UIKit/UIKit.h>

@interface LoginViewController : BaseViewController
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *selectPathView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;

- (IBAction)submit:(id)sender;


@end
