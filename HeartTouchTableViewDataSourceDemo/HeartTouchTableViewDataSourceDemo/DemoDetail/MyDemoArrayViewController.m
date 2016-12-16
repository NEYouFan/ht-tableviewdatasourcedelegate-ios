//
//  MyDemoArrayViewController.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/2/23.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyDemoArrayViewController.h"

#import "HTTableViewDataSourceDelegate.h"
#import "NSArray+DataSource.h"

#import "MyCellStringModel.h"
#import "MyTableViewCellModel.h"

#import "MyTableViewCell.h"

@interface MyDemoArrayViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic ,strong) id demoDataSource;

@end

@implementation MyDemoArrayViewController

- (NSArray <HTTableViewDataSourceDataModelProtocol> *)arrayCellModels
{
    return @[@"A", @"B", @"C", @"D", @"E", @"F"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
//    UINib * nib = [UINib nibWithNibName:@"UITableViewCell" bundle:[NSBundle mainBundle]];
//    [_tableview registerNib:nib forCellReuseIdentifier:@"UITableViewCell"];
    [_tableview  registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    id <HTTableViewDataSourceDataModelProtocol> cellModels = [self arrayCellModels];
    id <UITableViewDataSource, UITableViewDelegate> dataSource
    = [HTTableViewDataSourceDelegate dataSourceWithModel:cellModels
                                     cellTypeMap:@{@"NSString" : @"UITableViewCell"}
                               tableViewDelegate:nil                               cellConfiguration:
       ^(UITableViewCell *cell, NSString * model, NSIndexPath *indexPath) {
           [cell.textLabel setText:model];
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
@end
