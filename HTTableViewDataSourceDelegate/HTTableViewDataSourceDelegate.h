//
//  HTArrayDataSource.h
//  Demo
//
//  Created by 志强 on 16/1/18.
//  Copyright © 2016年 forkingdog. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTTableViewDataSourceDataModelProtocol;
@protocol HTTableViewCellModelProtocol;

typedef void(^HTTableViewConfigBlock)(id cell, id model, NSIndexPath * indexPath);

@interface HTTableViewDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

/**
 *  允许动态设置model
 */
@property (nonatomic, strong) id <HTTableViewDataSourceDataModelProtocol> model;

/**
 *  对协议HTTableViewDataSourceDelegateVisibleProtocol的实现，该属性影响dataSourceDelegate在
 *  HTTableViewCompositeDataSourceDelegate中是否显示。
 *  使用场景：load more的显示；
 */
@property (nonatomic, assign, setter = setHt_Visible:) BOOL isHt_Visible;

/**
 *  根据cellTypeMaps从cellModel中查找到指定的cell identifier
 *  允许自定义映射规则
 *
 *  @param cellModel cellModel对象
 *
 *  @return cell identifier
 */
- (NSString*)cellIdentifierForCellModelClass:(id)cellModel;

/**
 *  构造一个dataSource对象。注意，调用前要先注册使用到的cell，要么在storyboard中设置了原型cell的 identifier，要么在代码中使用-registerNib:forCellReuseIdentifier:或-registerClass:forCellReuseIdentifier:注册cell
 *
 *  @param model         dataSource model，根据协议HTTableViewDataSourceDataModelProtocol取得数据
 *  @param cellTypeMap   描述cell model 到cell identifier 或 cell class的对应关系
 *  @param tableViewDelegate 传入需要实现UITableViewDelegate接口的view controller，注意高度计算接口已经被实现
 *  @param configuration cell 设置完 model 后额外的设置cell属性的机会，可根据 indexPath 配置cell。cell 高度计算：默认使用auto layout约束来计算cell高度；如果没有使用auto layout，必须在block中添加一行代码：cell.fd_enforceFrameLayout = YES;并且在cell实现文件中实现-[UIView sizeThatFits:]方法，才能计算出正确的 cell 高度
 *
 *  @return dataSource对象
 */
+ (instancetype)dataSourceWithModel:(id < HTTableViewDataSourceDataModelProtocol >)model
                        cellTypeMap:(NSDictionary < NSString * , NSString *> *)cellTypeMap
                  tableViewDelegate:(id <UITableViewDelegate>)tableViewDelegate
                  cellConfiguration:(HTTableViewConfigBlock)configuration;

@end



