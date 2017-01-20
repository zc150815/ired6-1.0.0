//
//  SQRegisterView.h
//  ired6
//
//  Created by zhangchong on 2017/1/11.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQRegisterView;
@protocol  SQRegisterViewDelegate<NSObject>
-(void)registerView:(SQRegisterView*)registerView withNextButton:(UIButton*)nextButton;
@end

@interface SQRegisterView : UIView
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,copy) NSString *buttonStr;
@property (nonatomic,assign) UIKeyboardType keyboard;

@property (nonatomic, weak) id<SQRegisterViewDelegate> delegate;
@end
