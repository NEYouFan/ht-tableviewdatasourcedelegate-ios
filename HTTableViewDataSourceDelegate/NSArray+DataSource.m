//
//  NSArray+DataSource.m
//  Demo
//
//  Created by 志强 on 16/1/18.
//  Copyright © 2016年 forkingdog. All rights reserved.
//

#import "NSArray+DataSource.h"
/**
 *  NSArray 暂时不支持二维数组的，有需要支持二维数组的情况需要自己修改，参考MyInterestList+HTTableViewDataSource.m
 */

@implementation NSArray (DataSource)

- (NSUInteger)ht_sectionCount
{
    return 1;
}

- (NSUInteger)ht_rowCountAtSectionIndex:(NSUInteger)section
{
    NSAssert(section == 0, @"Only support 1D array temporary!");
    return self.count;
}

- (id)ht_itemAtSection:(NSUInteger)section rowIndex:(NSUInteger)row
{
    NSAssert(section == 0, @"Only support 1D array temporary!");
    return [self objectAtIndex:row];
}

@end
