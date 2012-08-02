//
//  UZLazyLoadTableView.m
//  UrbanZombie
//
//  Created by Justin Leger on 7/16/12.
//  Copyright (c) 2012 Leger Incorporated. All rights reserved.
//

#import "JTLazyLoadTableView.h"
#import "JTLazyLoadTableViewCell.h"

@implementation JTLazyLoadTableView

#pragma mark - Elastic Header
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
	if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [self loadImagesForOnscreenRows];
}


#pragma mark - LazyImageLoading Method

- (void)loadImagesForOnscreenRows
{
    NSArray *visiblePaths = [self indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visiblePaths)
    {
        UITableViewCell * cell = (UITableViewCell *)[self cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[JTLazyLoadTableViewCell class]]) {
			[cell performSelector:@selector(loadLazyLoadImages)];
		}
    }
}

@end
