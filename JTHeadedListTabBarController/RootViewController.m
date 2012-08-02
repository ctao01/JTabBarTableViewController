//
//  RootViewController.m
//  JTHeadedListTabBarController
//
//  Created by Joy Tao on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "aTabTableView.h"
#import "bTabTableView.h"

#define UZColorNavigationBarTint			UIColorFromHexRGBA(0x3e0a10ff)

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        aTabTableView * aTableView = [[aTabTableView alloc]init];
        aTableView.tabTitle = @"Tab A";
        aTableView.delegate = aTableView;
        aTableView.dataSource = aTableView;
        
        bTabTableView * bTableView = [[bTabTableView alloc]init];
        bTableView.tabTitle = @"Tab B";
        bTableView.delegate = bTableView;
        bTableView.dataSource = bTableView;
        
        self.tableviews = [NSArray arrayWithObjects:aTableView, bTableView, nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = UZColorNavigationBarTint;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - MHTabBarView Delegate Method

- (void) selectedIndexChanged:(NSUInteger)newSelectedIndex
{	
	[super selectedIndexChanged:newSelectedIndex];
	
    //	if (self.selectedIndex == newSelectedIndex) return;
	if (!self.tableviews || newSelectedIndex >= [self.tableviews count]) return;
		
}

@end
