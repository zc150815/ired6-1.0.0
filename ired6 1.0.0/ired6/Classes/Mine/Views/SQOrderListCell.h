//
//  SQOrderListCell.h
//  ired6
//
//  Created by zhangchong on 2017/2/8.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SQOrderTypeListModel,SQOrderListCell;

@protocol SQOrderListCellDelegate <NSObject>

-(void)orderListCell:(SQOrderListCell*)cell withClickButton:(UIButton*)sender;

@end
@interface SQOrderListCell : UITableViewCell

@property (nonatomic, strong) SQOrderTypeListModel *model;

@property (nonatomic, weak) id<SQOrderListCellDelegate> delegate;
@end
