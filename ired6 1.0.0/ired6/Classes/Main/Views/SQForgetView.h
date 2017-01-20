//
//  SQForgetView.h
//  ired6
//
//  Created by zhangchong on 2017/1/11.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQForgetView;
@protocol  SQForgetViewDelegate<NSObject>

-(void)forgetView:(SQForgetView*)forgetView withSureButton:(UIButton*)sender;
@end

@interface SQForgetView : UIView
@property (nonatomic, weak) id<SQForgetViewDelegate> delegate;
@end
