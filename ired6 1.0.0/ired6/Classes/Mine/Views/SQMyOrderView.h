//
//  SQMyOrderView.h
//  SQ565
//
//  Created by zhangchong on 16/12/13.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQMyOrderView;
@protocol  SQMyOrderViewDelegate<NSObject>

-(void)myOrderView:(SQMyOrderView*)myOrderView myOrderButtonActiton:(UIButton*)sender;

@end

@interface SQMyOrderView : UIView
@property (nonatomic, weak) id delegate;
@end
