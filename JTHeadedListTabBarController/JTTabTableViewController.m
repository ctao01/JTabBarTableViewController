//
//  JTTabTableViewController.m
//  JTHeadedListTabBarController
//
//  Created by Joy Tao on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JTTabTableViewController.h"

#define UI_STATUS_BAR_HEIGHT 20
#define UI_NAVIGATION_BAR_HEIGHT 44
#define ELASTIC_SNAP_THRESHOLD 20
#define TAB_BAR_HEIGHT 25
#define TAB_BAR_OVERLAY 4

#define HEADER_CELL_HEIGHT 100
#define ITEM_CELL_HEIGHT 480 - UI_STATUS_BAR_HEIGHT - TAB_BAR_HEIGHT +TAB_BAR_OVERLAY


@interface JTTabTableViewController ()
{
    BOOL direction;
}

@property (nonatomic , retain) UITableView * headerTableView;
@property (nonatomic , retain) JTTabTableView * itemTableView;

@end

@implementation JTTabTableViewController

@synthesize tableviews = _tableviews;
@synthesize selectedIndex = _selectedIndex;
@synthesize itemCell = _itemCell;
@synthesize headerCell = _headerCell;
@synthesize itemsTabBar;

@synthesize headerTableView = _headerTableView;
@synthesize itemTableView = _itemTableView;

- (void) dealloc
{
    [_tableviews release]; 
    [_itemCell release];
    [_headerCell release];
    [itemsTabBar release];
    
    [_headerCell release];

    if (_itemTableView)
    {
        [_itemTableView removeObserver:self forKeyPath:@"contentOffset" context:NULL];
        [_itemTableView release];
    }
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _itemCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemCell"];
        _headerCell = [[SMHeaderCellView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCell"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headerTableView = self.tableView;
    self.headerTableView.scrollEnabled = NO;
    
    // Initialzie HMTabBarView
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, TAB_BAR_HEIGHT);
    itemsTabBar = [[MHTabBarView alloc]initWithFrame:rect];
    itemsTabBar.delegate = self;
	
	NSMutableArray * tabTitles = [[NSMutableArray alloc] init];
	for(id aTable in self.tableviews) {
		if ([aTable isKindOfClass:[JTTabTableView class]]) {
			JTTabTableView * tabTable = (JTTabTableView *) aTable;
			[tabTitles addObject:tabTable.tabTitle];
		}
	}
    itemsTabBar.tabTitles = tabTitles;
    [_itemCell addSubview:itemsTabBar];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - iVar Setter / Getter Overrides

- (void) setItemTableView:(JTTabTableView *)itemTableView
{
	if (_itemTableView == itemTableView) return;
	
	if (_itemTableView)
		[_itemTableView removeObserver:self forKeyPath:@"contentOffset" context:NULL];
	
	[_itemTableView removeFromSuperview];
	
	_itemTableView = itemTableView;
	
	[_itemTableView addObserver:self forKeyPath:@"contentOffset"
					 options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
					 context:NULL];
	
	[_itemCell addSubview:_itemTableView];
	[_itemCell bringSubviewToFront:itemsTabBar];
	
}

- (void) setSelectedIndex:(NSUInteger)selectedIndex
{	
	if (_selectedIndex == selectedIndex) return;
	
	_selectedIndex = selectedIndex;
	
	[self selectedIndexChanged:selectedIndex];
}

#pragma mark - Sync Tables

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context 
{
    CGPoint newPoint = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    CGPoint oldPoint = [[change valueForKey:NSKeyValueChangeOldKey] CGPointValue];
    
    if(oldPoint.y > newPoint.y)
        direction = YES;
    else
        direction = NO;
    
    if(self.headerTableView.contentOffset.y < HEADER_CELL_HEIGHT)
    {
        if(newPoint.y > 0)
        {
            if(self.itemTableView.contentOffset.y != 0)
                [self.itemTableView setContentOffset:CGPointMake(0, 0)];
            
            if(self.headerTableView.contentOffset.y+newPoint.y < HEADER_CELL_HEIGHT)
                [self.headerTableView setContentOffset:CGPointMake(0, self.headerTableView.contentOffset.y+newPoint.y)];
            else
                [self.headerTableView setContentOffset:CGPointMake(0, HEADER_CELL_HEIGHT)];
        }
    }
    
    if(self.headerTableView.contentOffset.y <= HEADER_CELL_HEIGHT && self.itemTableView.contentOffset.y < 0)
    {
        if(self.headerTableView.contentOffset.y > 0)
        {        
            if(self.itemTableView.contentOffset.y != 0)
                [self.itemTableView setContentOffset:CGPointMake(0, 0)];
            
            if(self.headerTableView.contentOffset.y+newPoint.y > 0)
                [self.headerTableView setContentOffset:CGPointMake(0, self.headerTableView.contentOffset.y+newPoint.y)];
            else
                [self.headerTableView setContentOffset:CGPointMake(0, 0)];
        }
    }
}

#pragma mark - Elastic Header

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if(self.headerTableView.contentOffset.y < ELASTIC_SNAP_THRESHOLD)
            [self.headerTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        else if(self.headerTableView.contentOffset.y > HEADER_CELL_HEIGHT - ELASTIC_SNAP_THRESHOLD)
            [self.headerTableView setContentOffset:CGPointMake(0, HEADER_CELL_HEIGHT) animated:YES];
        else if(direction)
            [self.headerTableView setContentOffset:CGPointMake(0, HEADER_CELL_HEIGHT) animated:YES];
        else
            [self.headerTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if(direction || self.headerTableView.contentOffset.y == HEADER_CELL_HEIGHT)
        [self.headerTableView setContentOffset:CGPointMake(0, HEADER_CELL_HEIGHT) animated:YES];
    else
        [self.headerTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
		return 1;
	else if(section == 1)
		return 1;
	
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
		return _headerCell;
	else if(indexPath.section == 1)
		return _itemCell;
	
    return nil;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == 0)
		return HEADER_CELL_HEIGHT;
	else if(indexPath.section == 1)
		return ITEM_CELL_HEIGHT;
	
    return 0.0f;
}

#pragma mark - MHTabBarView Delegate Method

- (void) selectedIndexChanged:(NSUInteger)newSelectedIndex
{
    if (!self.tableviews || newSelectedIndex >= [self.tableviews count]) return;
	if (![[self.tableviews objectAtIndex:newSelectedIndex] isKindOfClass:[JTTabTableView class]]) return;
	
	self.itemTableView = [self.tableviews objectAtIndex:newSelectedIndex];
	
	[self.itemTableView setContentInset:UIEdgeInsetsMake(0,0,UI_NAVIGATION_BAR_HEIGHT ,0)];
    self.itemTableView.frame = CGRectMake(0, TAB_BAR_HEIGHT -TAB_BAR_OVERLAY, 320, ITEM_CELL_HEIGHT);
    self.itemTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0f, 0.0f,UI_NAVIGATION_BAR_HEIGHT, 0.0f);
    self.itemTableView.jtTabTableViewController = self;
    
    _selectedIndex = newSelectedIndex;

}

@end
