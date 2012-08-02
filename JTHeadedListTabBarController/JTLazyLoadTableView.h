//
//  UZLazyLoadTableView.h
//  UrbanZombie
//
//  Created by Justin Leger on 7/16/12.
//  Copyright (c) 2012 Leger Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTLazyLoadTableView : UITableView

#pragma mark - Elastic Header
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView;


#pragma mark - LazyImageLoading Method

- (void)loadImagesForOnscreenRows;

@end
