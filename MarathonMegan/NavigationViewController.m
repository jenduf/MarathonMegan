//
//  NavigationViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/9/13.
//
//

#import "NavigationViewController.h"
#import "BaseViewController.h"
#import "MenuCell.h"

@interface NavigationViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation NavigationViewController


- (BaseViewController *)topViewController
{
	return [self.childViewControllers lastObject];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.menuItems = @[@"GOALS", @"RUN", @"CALENDAR", @"COUCH POTATO"];
	
	[self.menuView setOrigin:CGPointMake(MENU_LEFT, self.menuView.top)];
}

- (IBAction)showMenu:(id)sender
{
	[UIView animateWithDuration:0.5 animations:^
	 {
		if(self.menuView.left < 0)
		{
			[self.menuView setOrigin:CGPointMake(0, self.menuView.top)];
			[self.menuView setBackgroundColor:[self.menuView.backgroundColor colorWithAlphaComponent:0.95]];
		}
		else
		{
			[self.menuView setOrigin:CGPointMake(MENU_LEFT, self.menuView.top)];
			[self.menuView setBackgroundColor:[self.menuView.backgroundColor colorWithAlphaComponent:0.5]];
		}
	 }];
}

- (void)addChildViewControllerWithIdentifier:(NSString *)identifier
{
	[self showMenu:nil];
	
	BaseViewController *viewControllerToRemove = (BaseViewController *)[self topViewController];
	BaseViewController *bvc = (BaseViewController *)[self.storyboard instantiateViewControllerWithIdentifier:identifier];
	[self.containerView addSubview:bvc.view];
	[self addChildViewController:bvc];
	
	[UIView animateWithDuration:0.5 animations:^
	{
		[bvc.view setOrigin:CGPointMake(0, 0)];
		[viewControllerToRemove.view setOrigin:CGPointMake(-self.view.width, 0)];
	}
	 completion:^(BOOL finished)
	{
		[bvc didMoveToParentViewController:self];
		[viewControllerToRemove willMoveToParentViewController:nil];
		[viewControllerToRemove removeFromParentViewController];
		[viewControllerToRemove.view removeFromSuperview];
	 }];
	
	
	NSLog(@"ViewController %@ Directly Replaced by %@ :: Child Views: %i", viewControllerToRemove, bvc, [self.childViewControllers count]);
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//	int numSections = [self.gameList getNumberOfSections];
	//	NSLog(@"Sections: %i", numSections);
	
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *reuseID = MENU_CELL_IDENTIFIER;
	
	MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:reuseID];
	
	NSString *currentMenuItem = self.menuItems[indexPath.row];
	
	cell.menuTitle.text = currentMenuItem;
	
	cell.icon.image = [UIImage imageNamed:[currentMenuItem lowercaseString]];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *currentMenuItem = self.menuItems[indexPath.row];
	
	NSString *nextIdentifier = [NSString stringWithFormat:@"%@ViewController", [[currentMenuItem lowercaseString] capitalizedString]];
	
	NSString *strippedString = [Utils removeWhitespaceFromString:nextIdentifier];
	
	[self addChildViewControllerWithIdentifier:strippedString];
	
	self.menuTitleLabel.text = currentMenuItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
