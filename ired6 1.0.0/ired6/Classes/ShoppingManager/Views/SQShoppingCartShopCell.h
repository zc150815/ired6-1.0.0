//
//  SQShoppingCartShopCell.h
//  ired6
//
//  Created by zhangchong on 2017/2/4.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQShoppingCartModel,SQShoppingCartShopCell;

@protocol SQShoppingCartShopCellDelegate <NSObject>

- (void)shoppingCartShopCell:(SQShoppingCartShopCell*)cell withSelectedModel:(SQShoppingCartModel*)model;

@end


@interface SQShoppingCartShopCell : UITableViewCell
//选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) SQShoppingCartModel *model;
@property (nonatomic, weak) id<SQShoppingCartShopCellDelegate> delegate;

@end
