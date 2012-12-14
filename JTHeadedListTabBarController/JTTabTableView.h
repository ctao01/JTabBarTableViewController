//
//  JTTabTableView.h
//  JTHeadedListTabBarController
//
//  Created by Joy Tao on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTLazyLoadTableView.h"

@class JTTabTableViewController;

@interface JTTabTableView : JTLazyLoadTableView

@property (nonatomic , assign) JTTabTableViewController * jtTabTableViewController;
@property (nonatomic , copy) NSString * tabTitle;

#pragma mark - Elastic Header

// Load images for all onscreen rows when scrolling is finished
- (void) scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate;
- (void) scrollViewDidEndDecelerating:(UIScrollView*)scrollView;

@end
