//
//  bottomPriceView.h
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BottomPriceView;
@protocol BottomPriceViewDelegate <NSObject>

- (void)bottomPriceView:(BottomPriceView *)bottonView buttonClickWith:(UIButton*)sender;

@end

@interface BottomPriceView : UIView

/**全选btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**结算按钮字符串*/
@property (nonatomic, copy) NSString *payStr;
/**合计字符串*/
@property (nonatomic, strong) NSString *attAllStr;
/**全选按钮状态*/
@property (nonatomic, assign) BOOL isSelectBtn;
/**代理*/
@property (weak, nonatomic) id<BottomPriceViewDelegate> delegate;

@end
