//
//  UZLazyLoadTableViewCell.h
//  UrbanZombie
//
//  Created by Justin Leger on 4/10/12.
//  Copyright (c) 2012 Leger Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTLazyLoadTableViewCell : UITableViewCell

// Add an UIImage to the an NSArray of images to receive the 
// SDWebImage WebCache startDownloadWithOptions when instructed to.

- (void) addLazyLoadImage:(UIImageView *)image;

- (void) removeLazyLoadImage:(UIImageView *)image;

- (void) loadLazyLoadImages;

@end
