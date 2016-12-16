//
//  MyTableViewCell.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/2/24.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MyTableViewCellModel.h"
#import "MyCellStringModel.h"
@interface MyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [self.contentView setBackgroundColor:nil];
    self.accessoryType = UITableViewCellAccessoryNone;
}

/**
 *  UITableViewCell设置数据的规范
 *  https://git.hz.netease.com/hzzhangping/heartouch/blob/master/specification/ios/UITableViewCell%E8%AE%BE%E7%BD%AE%E6%95%B0%E6%8D%AE%E7%9A%84%E8%A7%84%E8%8C%83.md
 *
 *  @param aModel cell的model
 */
-(void)setModel:(id)aModel
{
    if (_model == aModel) {
        return;
    }
    NSMutableString * selectorName = [@"set" mutableCopy];
    [selectorName appendString:NSStringFromClass([aModel class])];
    [selectorName appendString:@":"];
    SEL selector = NSSelectorFromString(selectorName);
    
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push //解除可能的内存泄露的警告
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:aModel];
#pragma clang diagnostic pop
    } else {
        NSAssert1(NO, @"unsupport cell class :%@", [aModel class]);
    }
}

- (void)setMyCellStringModel:(MyCellStringModel*)model
{
    _leftLabel.text = @"normal";
    [_button setTitle:model.title forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor orangeColor]];
}

- (void)setMyTableViewCellModel:(MyTableViewCellModel*)model
{
    _leftLabel.text = model.title;
    [_button setTitle:model.actionName forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor orangeColor]];
}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 100);
}

@end
