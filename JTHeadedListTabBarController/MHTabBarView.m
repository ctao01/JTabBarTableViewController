//
//  MHTabBarView.m
//  SMHeadedListCombinedViews
//
//  Created by Joy Tao on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MHTabBarView.h"

#define TAG_OFFSET  1000
#define DEVICE_OS [[[UIDevice currentDevice] systemVersion] intValue]

@implementation MHTabBarView
UIImageView * indicatorImageView;
UIImageView * oldIndicatorImg;

@synthesize tabTitles = _tabTitles;
@synthesize selectedTab = _selectedTab;
@synthesize delegate = _delegate;


#pragma mark - IndicatorImageView

- (void)centerIndicatorOnButton:(UIButton *)button
{
    CGRect rect = indicatorImageView.frame;
    
    rect.origin.x = button.center.x - floorf(indicatorImageView.frame.size.width/2.0f);
	rect.origin.y = self.frame.size.height - indicatorImageView.frame.size.height;
    indicatorImageView.frame = rect;
    indicatorImageView.hidden = NO;
}

#pragma mark - Button Action

- (void)selectTabButton:(UIButton *)button
{
    //[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (DEVICE_OS < 6.0f)
    {
        UIImage *image = [[UIImage imageNamed:@"UZProfileTabActive"] stretchableImageWithLeftCapWidth:6 topCapHeight:1];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        
//        [button setTitleColor:[UIColor colorWithRed:226/255.0f green:218/255.0f blue:211/255.0f alpha:1.0f] forState:UIControlStateNormal];
	}
    else
        [button setBackgroundColor:[UIColor redColor]];
    //[button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.5f] forState:UIControlStateNormal];
	
//	button.layer.shadowColor = [UZColorProfileStatsShadow CGColor];
//	button.layer.shadowOffset = CGSizeMake(0, 3);
//	button.layer.shadowOpacity = 0.8f;
//	button.layer.shadowRadius = 3.0;
	
}

- (void)deselectTabButton:(UIButton *)button
{
	//[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (DEVICE_OS < 6.0f)
	{
        UIImage *image = [[UIImage imageNamed:@"UZProfileTabInactive"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
	else
        [button setBackgroundColor:[UIColor lightGrayColor]];

}

- (void)removeTabButtons
{
	NSArray *buttons = [self subviews];
	for (UIButton *button in buttons)
		[button removeFromSuperview];
}

- (void)addTabButtons
{
	NSUInteger index = 0;
	for (NSString *title in self.tabTitles)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = TAG_OFFSET + index;
		[button setTitle:title forState:UIControlStateNormal];
		[button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchDown];
		//button.titleLabel.shadowOffset = CGSizeMake(0, 1);
		
		[button setTitleEdgeInsets:UIEdgeInsetsMake(-5.0, 0.0, 0.0, 0.0)];
		
//		CGRect rect = button.titleLabel.frame;
//		rect.origin.y = rect.origin.y - 10;
//		button.titleLabel.frame = rect;
		
		[self deselectTabButton:button];
		[self addSubview:button];
        
		++index;
	}
    
}

- (void)reloadTabButtons
{
	[self removeTabButtons];
	[self addTabButtons];
    
    
	// Force redraw of the previously active tab.
	NSUInteger lastIndex = _selectedTab;
	_selectedTab = NSNotFound;
	self.selectedTab = lastIndex;
}

- (void)layoutTabButtons
{
    
	NSUInteger index = 0;
	NSUInteger count = [self.tabTitles count];
    
	CGRect rect = CGRectMake(0, 0, floorf(self.bounds.size.width / count), self.frame.size.height);
	
	NSLog(@"%@", NSStringFromCGRect(rect));
    
	indicatorImageView.hidden = YES;
    
	NSArray * buttons = [self subviews];
	for (UIButton *button in buttons)
	{
		if (index == count - 1)
			rect.size.width = self.bounds.size.width - rect.origin.x;
        
		button.frame = rect;
		rect.origin.x += rect.size.width;
        
		if (index == _selectedTab)
        {
	//		[self centerIndicatorOnButton:button]; 
            
        }
		++index;
	}
    
}

#pragma mark - Set up MHTabBarView

- (void) baseInit
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        indicatorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MHTabBarIndicator"]];
    }
    return self;
}

- (void) layoutSubviews 
{
    [super layoutSubviews];
    
    [self reloadTabButtons];
    
    [self layoutTabButtons];
    [self addSubview:indicatorImageView];
    [self bringSubviewToFront:indicatorImageView];        
}

#pragma mark - Select Tabs Method

//-(void)slideInCompleted:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
//    UIView *view = (UIView *)context;
//    [view removeFromSuperview];
//}

- (void)setSelectedTab:(NSUInteger)newSelectedTab 
{
    [self setSelectedTab:newSelectedTab animated:NO];
}

- (void) setSelectedTab:(NSUInteger)newSelectedTab animated:(BOOL)animated
{
    if (!self) 
    {
        _selectedTab = newSelectedTab;
    }
    else if (_selectedTab != newSelectedTab)
    {
        
        if (_selectedTab != NSNotFound)
        {
            UIButton * fromButton = (UIButton *)[self viewWithTag:TAG_OFFSET + _selectedTab];
            [self deselectTabButton:fromButton];
        }
        
        _selectedTab = newSelectedTab;
        
        UIButton * toButton;
        if (_selectedTab != NSNotFound)
        {
            toButton = (UIButton *)[self viewWithTag:TAG_OFFSET + _selectedTab];
			[self selectTabButton:toButton]; 
        }
        
        if (animated)
		{
			self.userInteractionEnabled = NO;
            
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options: UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                             animations:^{
								 
                             } 
                             completion:^(BOOL finished){
                                 self.userInteractionEnabled = YES;
                                 NSLog(@"Done!");
                                 if ([self.delegate respondsToSelector:@selector(selectedIndexChanged:)])
                                     [self.delegate selectedIndexChanged:newSelectedTab];
                             }];
		}
		else  // not animated
		{
         //   [self centerIndicatorOnButton:toButton];
            
            if ([self.delegate respondsToSelector:@selector(selectedIndexChanged:)])
                [self.delegate selectedIndexChanged:newSelectedTab];
            
		}
    }
}


- (void)tabButtonPressed:(UIButton *)sender
{   
	[self setSelectedTab:sender.tag - TAG_OFFSET];
}

@end
