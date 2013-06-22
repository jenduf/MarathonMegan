//
//  NavigationViewController.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/9/13.
//
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLabel;

- (void)addChildViewControllerWithIdentifier:(NSString *)identifier;
- (IBAction)showMenu:(id)sender;

@end
