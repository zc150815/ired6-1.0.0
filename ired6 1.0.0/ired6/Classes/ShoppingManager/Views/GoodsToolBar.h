//
//  GoodsToolBar.h
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsToolBar;
@protocol GoodsToolBarDelegate <NSObject>

- (void)goodsToolBar:(GoodsToolBar *)goodsToolBar withButtonClick:(UIButton*)sender;
@end


@interface GoodsToolBar : UIView

@property (weak, nonatomic) id<GoodsToolBarDelegate> delegate;


@end
