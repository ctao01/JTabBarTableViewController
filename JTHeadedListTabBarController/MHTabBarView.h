//
//  MHTabBarView.h
//  SMHeadedListCombinedViews
//
//  Created by Joy Tao on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHTabBarView;

@protocol MHTabBarViewDelegate <NSObject>

@optional

- (void) selectedIndexChanged:(NSUInteger)newSelectedIndex;


@end

@interface MHTabBarView : UIView

@property (nonatomic , strong) NSArray * tabTitles;
@property (nonatomic , assign) NSUInteger selectedTab;
@property (nonatomic , unsafe_unretained) id <MHTabBarViewDelegate> delegate;

//- (void) setSelectedTab:(NSUInteger)newSelectedTab;
- (void) reloadTabButtons;
- (void) layoutTabButtons ;

- (void) setSelectedTab:(NSUInteger)newSelectedTab animated:(BOOL)animated;

@end
