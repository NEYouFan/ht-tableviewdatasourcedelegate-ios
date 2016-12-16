//
//  MyInterestList.h
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/21.
//  Copyright © 2016年 志强. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  table view 所有数据的提供类，测试从现有数组集合转换成
 *  HTTableViewDataSourceDataModelProtocol的过程
 */
@interface MyInterestList : NSObject

+ (instancetype)interestListWithSport;

- (NSArray*)interestListDataArray;
@end
