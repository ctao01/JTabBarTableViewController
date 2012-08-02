//
//  RootViewController.h
//  JTHeadedListTabBarController
//
//  Created by Joy Tao on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JTTabTableViewController.h"

// Hex RGBA color macro with alpha
#define UIColorFromHexRGBA(hexRGBAValue) [UIColor			\
colorWithRed:((hexRGBAValue>>24)&0xFF)/255.0f			\
green:((hexRGBAValue>>16)&0xFF)/255.0f					\
blue:((hexRGBAValue>>8)&0xFF)/255.0f					\
alpha:((hexRGBAValue)&0xFF)/255.0f						]

// Hex RGB color macro with alpha
#define UIColorFromHexRGB(hexRGBValue) [UIColor				\
colorWithRed:((hexRGBValue>>16)&0xFF)/255.0f			\
green:((hexRGBValue>>8)&0xFF)/255.0f					\
blue:((hexRGBValue)&0xFF)/255.0f						\
alpha:1.0f	

@interface RootViewController : JTTabTableViewController

@end
