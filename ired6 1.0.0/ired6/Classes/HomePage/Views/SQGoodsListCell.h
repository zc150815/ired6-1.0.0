//
//  SQGoodsListCell.h
//  ired6
//
//  Created by zhangchong on 2017/2/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GridListModel,SQGoodsListCell;

@protocol  SQGoodsListCellDelegate<NSObject>

-(void)goodsListCell:(SQGoodsListCell*)cell addShoppingCartWithButton:(UIButton*)sender;

@end
@interface SQGoodsListCell : UICollectionViewCell

/**
 0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isGrid;

@property (nonatomic, strong) GridListModel *model;
@property (nonatomic, weak) id<SQGoodsListCellDelegate> delegate;
@end
