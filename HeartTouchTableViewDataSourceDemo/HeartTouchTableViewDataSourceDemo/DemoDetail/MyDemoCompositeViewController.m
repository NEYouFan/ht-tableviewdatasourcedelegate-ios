//
//  MyDemoCompositeViewController.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/2/23.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyDemoCompositeViewController.h"
#import "HTTableViewDataSourceDelegate.h"
#import "HTTableViewCompositeDataSourceDelegate.h"
#import "NSArray+DataSource.h"
#import "MyCellStringModel.h"
#import "MyTableViewCellModel.h"
#import "MyTableViewCell.h"

@interface MyDemoCompositeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic ,strong) HTTableViewCompositeDataSourceDelegate * compositeDataSource;

@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, weak) HTTableViewDataSourceDelegate * singleSectionDataSource;

@end

@implementation MyDemoCompositeViewController

- (NSArray <HTTableViewDataSourceDataModelProtocol> *)arrayCellModels
{
    NSMutableArray * models = [NSMutableArray new];
    for (NSString * arg in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
        [models addObject:[MyCellStringModel modelWithTitle:arg]];
    }
    return models;
}

- (NSArray <HTTableViewDataSourceDataModelProtocol> *)customClassCellModels
{
    NSMutableArray * modelList = [NSMutableArray new];
    for (int index = 0; index < 6; index ++ ) {
        [modelList addObject:[MyTableViewCellModel modelWithTitle:[NSString stringWithFormat:@"%d",index] name:@"normal"]];
    }
    return modelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    UINib * nib = [UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableview registerNib:nib forCellReuseIdentifier:@"MyTableViewCell"];
    
    //first data source
    HTTableViewDataSourceDelegate * dataSource1 =
    [HTTableViewDataSourceDelegate dataSourceWithModel:[self arrayCellModels]
                                   cellTypeMap:@{@"MyCellStringModel" : @"MyTableViewCell"}
                             tableViewDelegate:nil
                             cellConfiguration:
     ^(MyTableViewCell *cell, id model, NSIndexPath *indexPath) {
         [cell setModel:model];
         if (indexPath.row % 2 == 0) {
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         } else {
             cell.accessoryType = UITableViewCellAccessoryCheckmark;
         }
         if (indexPath.section == 1) {
             [cell.contentView setBackgroundColor:[UIColor grayColor]];
         }
     }];
    
    //second data source
    HTTableViewDataSourceDelegate * modelDataSource =
    [HTTableViewDataSourceDelegate dataSourceWithModel:[self customClassCellModels]
                                   cellTypeMap:@{@"MyTableViewCellModel" : @"MyTableViewCell"}
                             tableViewDelegate:nil
                             cellConfiguration:
     ^(MyTableViewCell *cell, id model, NSIndexPath *indexPath) {
         [cell setModel:model];
         cell.accessoryType = UITableViewCellAccessoryDetailButton;
     }];
    
    
    
    //one item data source
    NSArray * oneItemModel = @[[MyCellStringModel modelWithTitle:@"more content"]];
    HTTableViewDataSourceDelegate * oneItemDataSource =
    [HTTableViewDataSourceDelegate dataSourceWithModel:oneItemModel
                                           cellTypeMap:@{@"MyCellStringModel" : @"MyTableViewCell"}
                                     tableViewDelegate:nil
                                     cellConfiguration:nil];
    _singleSectionDataSource = oneItemDataSource;
    
    //composite data source
    NSMutableArray < UITableViewDataSource, UITableViewDelegate >* dataSourceList = @[].mutableCopy;
    [dataSourceList addObject:dataSource1];
    [dataSourceList addObject:modelDataSource];
    [dataSourceList addObject:oneItemDataSource];
    
    HTTableViewCompositeDataSourceDelegate * dataSource
    = [HTTableViewCompositeDataSourceDelegate dataSourceWithDataSources:dataSourceList];
    dataSource.tableViewDelegate = self;
    _tableview.dataSource = dataSource;
    _tableview.delegate = dataSource;
    self.compositeDataSource = dataSource;
    [_tableview reloadData];
    
    [self addBtn];
}

- (void)addBtn
{
    float btnHeight = 40;
    CGRect bounds = self.view.bounds;
    CGRect rect = CGRectMake(0, CGRectGetHeight(bounds) - btnHeight - 100, 260, btnHeight);
    _btn = [[UIButton alloc] initWithFrame:rect];
    [_btn addTarget:self action:@selector(performPress:) forControlEvents:UIControlEventTouchDown];
    [_btn setBackgroundColor:[UIColor brownColor]];
    [_btn setTitle:@"press me to hide or show cell" forState:UIControlStateNormal];
    [self.view addSubview:_btn];
}
- (IBAction)performPress:(id)sender
{
    [_singleSectionDataSource setHt_Visible:![_singleSectionDataSource isHt_Visible]];
    [_tableview reloadData];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Header for mixed by composite dataSource";
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        HTTableViewDataSourceDelegate * htDataSource = _compositeDataSource.dataSourceList[section];
        if ([htDataSource isKindOfClass:[HTTableViewDataSourceDelegate class]] == NO) {
            return nil;
        }
        MyCellStringModel * model = [htDataSource.model ht_itemAtSection:0 rowIndex:0];
        
        static NSString *kFootView = @"footerView";
        UITableViewHeaderFooterView *myFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFootView];
        if(!myFooter) {
            myFooter = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kFootView];
        }
        
        myFooter.textLabel.text = [@"Footer" stringByAppendingFormat:@" for %@ by composite delegate",model.title];
        [myFooter setFrame:CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section])];
        return myFooter;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    } else {
        return 0;
    }
}
@end
