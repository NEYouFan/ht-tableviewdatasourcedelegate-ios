//
//  MyDemoUserModelViewController.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/2/23.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyDemoUserModelViewController.h"

#import "HTTableViewDataSourceDelegate.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "NSArray+DataSource.h"

#import "MyInterestList.h"
#import "MyInterestList+HTTableViewDataSource.h"

#import "MyCellStringModel.h"
#import "MyTableViewCellModel.h"

#import "MyTableViewCell.h"
#import "MyDelegateTableViewCell.h"

#import "MyCustomHTTableViewDataSource.h"

@interface MyDemoUserModelViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic ,strong) id demoDataSource;

@property (nonatomic, strong) id <HTTableViewDataSourceDataModelProtocol> dataModel;

@end

@implementation MyDemoUserModelViewController

- (NSArray <HTTableViewDataSourceDataModelProtocol> *)arrayCellModels
{
    NSMutableArray * models = [NSMutableArray new];
    for (NSString * arg in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
        [models addObject:[MyCellStringModel modelWithTitle:arg]];
    }
    return models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    UINib * nib = [UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableview registerNib:nib forCellReuseIdentifier:@"MyTableViewCell"];
    
    nib = [UINib nibWithNibName:@"MyDelegateTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableview registerNib:nib forCellReuseIdentifier:@"MyDelegateTableViewCell"];
    
    _dataModel = [MyInterestList interestListWithSport];
    
    id <UITableViewDataSource, UITableViewDelegate> dataSource
    = [MyCustomHTTableViewDataSource dataSourceWithModel:_dataModel
                                     cellTypeMap:@{@"MyCellStringModel" : @"MyTableViewCell", @"MyTableViewCellModel" : @"MyTableViewCell"}
                               tableViewDelegate:self
                               cellConfiguration:
       ^(MyDelegateTableViewCell *cell, id model, NSIndexPath *indexPath) {
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
    
    _tableview.dataSource = dataSource;
    _tableview.delegate = dataSource;
    self.demoDataSource = dataSource;
    [_tableview reloadData];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        MyCellStringModel * model = [_dataModel ht_itemAtSection:section rowIndex:0];
        
        static NSString *kFootView = @"footerView";
        UITableViewHeaderFooterView *myFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFootView];
        if(!myFooter) {
            myFooter = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kFootView];
        }
        
        myFooter.textLabel.text = [@"Footer" stringByAppendingFormat:@" for %@ by Delegate",model.title];
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
