//
//  JTTabTableView.m
//  JTHeadedListTabBarController
//
//  Created by Joy Tao on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JTTabTableView.h"
#import "JTLazyLoadTableView.h"

@implementation JTTabTableView

@synthesize jtTabTableViewController = _jtTabTableViewController;
@synthesize tabTitle = _tabTitle;

#pragma mark - Elastic Header

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [self.jtTabTableViewController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	
	// Load images for all onscreen rows when scrolling is finished
	[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [self.jtTabTableViewController scrollViewDidEndDecelerating:scrollView];
	
	// Load images for all onscreen rows when scrolling is finished
	[super scrollViewDidEndDecelerating:scrollView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
