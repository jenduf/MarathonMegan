//
//  MainPanelViewController.m
//  MarathonMegan
//
//  Created by Jennifer Duffey on 3/9/13.
//
//

#import "MainPanelViewController.h"

@interface MainPanelViewController ()



@end

@implementation MainPanelViewController

- (id)init
{
	self = [super init];
	
	if(self)
	{
		//self.sideBarItem.title = @"First";
		//self.sideBarItem.image = [UIImage imageNamed:@"Icon_Activity"];
		//self.sideBarItem.isGlowing = YES;
	}
	
	return self;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	//[self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
