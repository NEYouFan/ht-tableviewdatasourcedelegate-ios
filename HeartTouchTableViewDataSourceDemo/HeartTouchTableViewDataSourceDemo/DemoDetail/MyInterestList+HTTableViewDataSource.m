//
//  MyInterestList+HTTableViewDataSource.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/21.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyInterestList+HTTableViewDataSource.h"
#import "MyTableViewCellModel.h"
#import <objc/runtime.h>

/**
 *  实现多个section的功能
 */
@implementation MyInterestList (HTTableViewDataSource)

- (NSUInteger)ht_sectionCount
{
    return [[self interestListDataArray] count];
}

- (NSUInteger)ht_rowCountAtSectionIndex:(NSUInteger)section
{
    id value = [self interestListDataArray][section];
    
    if ([value isKindOfClass:[NSArray class]]) {
        NSArray * list = value;
        return list.count;
    } else {
        return 1;
    }
}

- (id)ht_itemAtSection:(NSUInteger)section rowIndex:(NSUInteger)row
{
    id item = [self interestListDataArray][section];
    
    if ([item isKindOfClass:[NSArray class]]) {
        NSArray * array = item;
        return array[row];
    } else {
        return item;
    }
}

@end
