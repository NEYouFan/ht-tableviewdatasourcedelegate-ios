//
//  MyCustomHTTableViewDataSource.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/22.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyCustomHTTableViewDataSource.h"

@implementation MyCustomHTTableViewDataSource

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Header for mixed by DataSource";
}

@end
