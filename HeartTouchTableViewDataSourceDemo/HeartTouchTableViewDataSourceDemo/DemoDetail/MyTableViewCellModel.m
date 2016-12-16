//
//  MyTableViewCellModel.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/18.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyTableViewCellModel.h"

@implementation MyTableViewCellModel

+ (instancetype)modelWithTitle:(NSString *)title name:(NSString*)name
{
    MyTableViewCellModel * instance = [MyTableViewCellModel new];
    instance.title = title;
    instance.actionName = name;
    return instance;
}
@end
