//
//  MyDelegateTableViewCell.h
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/21.
//  Copyright © 2016年 志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDelegateTableViewCellDelegate <NSObject>

- (void)selectedButtonWithContent:(NSString *)content;

@end

@interface MyDelegateTableViewCell : UITableViewCell

@property (nonatomic, strong) id model;

@property (nonatomic, weak) id <MyDelegateTableViewCellDelegate> delegate;

@end
