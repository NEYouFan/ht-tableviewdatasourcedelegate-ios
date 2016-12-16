//
//  HTTableViewCellModelProtocol.h
//  HeartTouchTableViewDataSourceDemo
//
//  Created by 志强 on 16/1/22.
//  Copyright © 2016年 志强. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HeartTouch standard: Custom UITableViewCell should conform this protocol
 */
@protocol HTTableViewCellModelProtocol <NSObject>

@property (nonatomic, strong) id model;

@end
