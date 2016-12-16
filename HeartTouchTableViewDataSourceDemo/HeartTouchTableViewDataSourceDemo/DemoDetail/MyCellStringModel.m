//
//  MyTableViewIntervalCellModel.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/26.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyCellStringModel.h"

@implementation MyCellStringModel

+ (instancetype)modelWithTitle:(NSString *)title
{
    MyCellStringModel * instance = [MyCellStringModel new];
    instance.title = title;
    return instance;
}

@end
