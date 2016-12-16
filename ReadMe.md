HTTableViewDataSourceDelegate
---
在UIViewController瘦身这一热门话题中，UITableView属于主要目标。  
`HTTableViewDataSourceDelegate`抽离了view controller中table view的dataSource接口和部分与UI无关的delegate接口，包括cell的高度计算方法。

特性
---

* 实现cell高度计算
* 使用组合方式实现完成多个dataSource的合并显示
* 抽离UITableViewDelegate的高度计算接口，其余接口仍然可以在页面中实现，不会影响到与页面耦合较多的接口

用法
---

导入头文件

	#import "HTTableViewDataSourceDelegate.h"
	#import "NSArray+DataSource.h" //数据列表在这里完成协议的遵守，参考下面对model参数的解释
	#import "MyCellStringModel.h"	//cell model类型
	#import "MyTableViewCell.h"		//cell类型，遵守协议HTTableViewCellModelProtocol
	
构造数据集合

	- (id <HTTableViewDataSourceDataModelProtocol>)arrayCellModels
	{
	    NSMutableArray * models = [NSMutableArray new];
	    for (NSString * arg in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
	        [models addObject:[MyCellStringModel modelWithTitle:arg]];
	    }
	    return models;
	}
构造 dataSourceDelegate实例

		id <HTTableViewDataSourceDataModelProtocol> cellModels = [self arrayCellModels];//用户的数据列表
	    id <UITableViewDataSource, UITableViewDelegate> dataSource
	    = [HTTableViewDataSourceDelegate dataSourceWithModel:cellModels
	                                     cellTypeMap:@{@"MyCellStringModel" : @"MyTableViewCell"}// 数据类到cell类名的映射
	                               tableViewDelegate:self
	                               cellConfiguration:
	       ^(UITableViewCell *cell, NSIndexPath *indexPath) {
	        if (indexPath.row % 2 == 0) {
	            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	        }
	    }];
	    
使用dataSourceDelegate

		self.demoDataSource = dataSource;//持有 dataSource
	    _tableview.dataSource = dataSource;
	    _tableview.delegate = dataSource;
	    [_tableview reloadData]; 
	    
---
###	CocoaPods
1. 在Podfile中添加 `pod 'HTTableViewDataSourceDelegate', :git => 'https://g.hz.netease.com/HeartTouchOpen/HTTableViewDataSourceDelegate.git', :branch => 'master'`
2. 执行`pod install`或`pod update`
3. 导入头文件HTTableViewDataSourceDelegate.h
	
系统要求
---

该项目最低支持`iOS 7.0`和`Xcode 7.0`

许可证
---

HTTableViewDataSourceDelegate使用MIT许可证，详情见LICENSE文件。
	