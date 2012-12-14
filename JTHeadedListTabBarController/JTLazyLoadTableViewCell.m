//
//  UZLazyLoadTableViewCell.m
//  UrbanZombie
//
//  Created by Justin Leger on 4/10/12.
//  Copyright (c) 2012 Leger Incorporated. All rights reserved.
//

#import "JTLazyLoadTableViewCell.h"
#import "UIImageView+WebCache.h"
//#import "SDImageCache.h"

@interface JTLazyLoadTableViewCell () {
	NSMutableArray * _lazyLoadImages;
}
@end

@implementation JTLazyLoadTableViewCell

- (void) dealloc
{	
    [super dealloc];
    
	if ([_lazyLoadImages count] > 0)
		[_lazyLoadImages makeObjectsPerformSelector:@selector(cancelCurrentImageLoad)];
	
	[_lazyLoadImages removeAllObjects];
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		_lazyLoadImages = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) addLazyLoadImage:(UIImageView *)image
{
	if (![_lazyLoadImages containsObject:image])
		[_lazyLoadImages addObject:image];
//    NSLog(@"Count %i", [_lazyLoadImages count]);
}

- (void) removeLazyLoadImage:(UIImageView *)image
{
		[_lazyLoadImages removeObject:image];
		[image cancelCurrentImageLoad];
}

- (void) loadLazyLoadImages
{
	if ([_lazyLoadImages count] > 0) {
		[_lazyLoadImages makeObjectsPerformSelector:@selector(startDownloadWithOptions:) withObject:nil];
    }
}

@end
