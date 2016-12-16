//
//  MyDelegateTableViewCell.m
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/21.
//  Copyright © 2016年 志强. All rights reserved.
//

#import "MyDelegateTableViewCell.h"
#import "MyTableViewCellModel.h"

@interface MyDelegateTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@end
@implementation MyDelegateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(MyTableViewCellModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    [_btn1 setTitle:model.title forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchDown];
    [_btn2 setTitle:model.actionName forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchDown];
    NSString * additionString = [model.title stringByAppendingFormat:@" %@",model.actionName];
    [_btn3 setTitle:additionString forState:UIControlStateNormal];
    [_btn3 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchDown];
}

-(IBAction)pressBtn:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectedButtonWithContent:)]) {
        [_delegate selectedButtonWithContent:sender.titleLabel.text];
    }
}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 100);
}
@end
