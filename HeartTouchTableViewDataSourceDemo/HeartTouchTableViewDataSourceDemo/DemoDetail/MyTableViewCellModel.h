//
//  MyTableViewCellModel.h
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/18.
//  Copyright © 2016年 志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTableViewCellModel : NSObject

+ (instancetype)modelWithTitle:(NSString *)title name:(NSString*)name;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * actionName;

@end
