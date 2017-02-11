//
//  SQOrderTypeListModel.h
//  ired6
//
//  Created by zhangchong on 2017/2/8.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQOrderTypeListModel : NSObject


@property (nonatomic,copy) NSString *ShopName;//商店名字
@property (nonatomic,copy) NSString *ShopIcon;//商店图标
@property (nonatomic,copy) NSString *OrderType;//订单类型
@property (nonatomic,copy) NSString *OrderAmount;//订单金额
@property (nonatomic, strong) NSArray *OrderGoods;//订单商品组


@end
