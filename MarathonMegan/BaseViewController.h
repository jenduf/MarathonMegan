//
//  BaseViewController.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) id containerController;

- (IBAction)showMenu:(id)sender;
- (IBAction)goBack:(UIStoryboardSegue *)segue;
- (IBAction)logOut:(id)sender;
- (void)showErrorWithMessage:(NSString *)message;
+ (id)containerControllerKindOfClass:(Class)containerControllerClass forViewController:(UIViewController *)viewController;

@end
