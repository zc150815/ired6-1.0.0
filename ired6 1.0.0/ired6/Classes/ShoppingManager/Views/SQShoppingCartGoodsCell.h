//
//  SQShoppingCartGoodsCell.h
//  ired6
//
//  Created by zhangchong on 2017/2/4.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQShoppingCartModel,SQShoppingCartGoodsCell;

@protocol SQShoppingCartGoodsCellDelegate <NSObject>

- (void)shoppingCartGoodsCell:(SQShoppingCartGoodsCell*)cell withSelectedModel:(SQShoppingCartModel*)model;
@end


@interface SQShoppingCartGoodsCell : UITableViewCell
//选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) SQShoppingCartModel *model;
@property (nonatomic, weak) id<SQShoppingCartGoodsCellDelegate> delegate;
@end
