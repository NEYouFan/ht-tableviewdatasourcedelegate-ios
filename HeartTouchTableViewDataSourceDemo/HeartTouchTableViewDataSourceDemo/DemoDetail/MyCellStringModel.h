//
//  MyTableViewIntervalCellModel.h
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/26.
//  Copyright © 2016年 志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCellStringModel : NSObject

+ (instancetype)modelWithTitle:(NSString *)title;

@property (nonatomic, copy) NSString * title;

@end
