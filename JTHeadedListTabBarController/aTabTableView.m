//
//  aTabTableView.m
//  JTHeadedListTabBarController
//
//  Created by Joy Tao on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "aTabTableView.h"
#import "JTLazyLoadTableViewCell.h"

@implementation aTabTableView

#pragma mark - UITableView Delegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    JTLazyLoadTableViewCell * jtTableViewCell = (JTLazyLoadTableViewCell *)[self dequeueReusableCellWithIdentifier:@"JTTableViewCell"];
    if (!jtTableViewCell)
        jtTableViewCell = [[JTLazyLoadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JTTableViewCell"];
    
    jtTableViewCell.textLabel.text = [NSString stringWithFormat:@"Tab-A, row-%i",indexPath.row];
    
    return jtTableViewCell;
}

#pragma mark - UITableView DataSource Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44;
}



@end
