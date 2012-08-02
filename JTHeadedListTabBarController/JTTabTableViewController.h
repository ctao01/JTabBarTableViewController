//
//  JTTabTableViewController.h
//  JTHeadedListTabBarController
//
//  Created by Joy Tao on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// vendors
#import "SMHeaderCellView.h"
#import "MHTabBarView.h"

#import "JTTabTableView.h"

@interface JTTabTableViewController : UITableViewController <UITableViewDelegate , MHTabBarViewDelegate>

// 
@property (nonatomic , retain) NSArray * tableviews;
@property (nonatomic , assign) NSUInteger selectedIndex;

@property (nonatomic , retain , readonly) UITableViewCell * itemCell;
@property (nonatomic , retain , readonly) SMHeaderCellView * headerCell;
@property (nonatomic , retain , readonly) MHTabBarView * itemsTabBar;

@end
