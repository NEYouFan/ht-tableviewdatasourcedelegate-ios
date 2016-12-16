//
//  HTTableViewCompositeDataSource.h
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/19.
//  Copyright © 2016年 志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTTableViewDataSourceDataModelProtocol;
/**
 *  连接多个dataSource对象，合并为一个。
 *  被连接的dataSource的调用没有受到连接的影响
 */
@interface HTTableViewCompositeDataSourceDelegate : NSObject < UITableViewDataSource, UITableViewDelegate >

@property (nonatomic, strong) NSArray < UITableViewDataSource, UITableViewDelegate > * dataSourceList;

/**
 * 使用这个delegate，支持额外 UITableViewDataSource 和 UITableViewDelegate 接口的配置
 */
@property (nonatomic, weak) id < UITableViewDataSource, UITableViewDelegate > tableViewDelegate;

/**
 *  将多个dataSource连接成一个新的dataSource
 *
 *  @param dataSources UITableViewDataSource list
 *
 *  @return dataSources composite result, a new dataSource
 */
+ (instancetype)dataSourceWithDataSources:(NSArray < UITableViewDataSource, UITableViewDelegate > *)dataSources;

@end
