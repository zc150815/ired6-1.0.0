//
//  SQForgetView.m
//  ired6
//
//  Created by zhangchong on 2017/1/11.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQForgetView.h"
#import "SQTextField.h"
#import "ZCKeyboard.h"

@interface SQForgetView ()

@property (nonatomic, strong) SQTextField *phoneNum;
@property (nonatomic, strong) SQTextField *verification;
@property (nonatomic, strong) UIButton *verificateBtn;
@property (nonatomic, strong) SQTextField *password;

@property (nonatomic,assign) NSInteger count;

@end
@implementation SQForgetView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        //手机号输入框
        _phoneNum = [[SQTextField alloc]init];
        _phoneNum.frame = CGRectMake(SQ_Fit(40), SQ_Fit(20), SQ_ScreenWidth-2*SQ_Fit(40), SQ_Fit(48));
        _phoneNum.leftViewStr = @"手机号";
        _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_phoneNum];
        
        //验证码输入框
        _verification = [[SQTextField alloc]init];
        _verification.frame = CGRectMake(_phoneNum.x, CGRectGetMaxY(_phoneNum.frame), _phoneNum.width, _phoneNum.height);
        _verification.leftViewStr = @"验证码";
        _verification.isPassword = YES;
        _verification.keyboardType = UIKeyboardTypeNumberPad;
        _verification.rightViewMode = UITextFieldViewModeAlways;
//        _verification.inputView = [ZCKeyboard keyboardWithTextField:_verification];
        [self addSubview:_verification];
        
        _verificateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verificateBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verificateBtn setTitle:@"验证码(60s)" forState:UIControlStateDisabled];
        [_verificateBtn setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
//        [verificateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_verificateBtn setBackgroundColor:[UIColor getColor:@"f2f2f2"]];
        _verificateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _verificateBtn.adjustsImageWhenHighlighted = NO;
        _verificateBtn.titleLabel.font = SQ_Font(SQ_Fit(12));
        [_verificateBtn addTarget:self action:@selector(verificateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _verificateBtn.frame = CGRectMake(0, 0, SQ_Fit(100), SQ_Fit(40));
        _verificateBtn.layer.cornerRadius = SQ_Fit(5);
        _verificateBtn.layer.masksToBounds = YES;
        _verification.rightView = _verificateBtn;
        
        //密码输入框
        _password = [[SQTextField alloc]init];
        _password.frame = CGRectMake(_verification.x, CGRectGetMaxY(_verification.frame), _verification.width, _verification.height);
        _password.leftViewStr = @"新密码";
        _password.isPassword = YES;
        _password.keyboardType = UIKeyboardTypeDefault;
        _password.secureTextEntry = YES;
        [self addSubview:_password];
        
        //重置密码按钮
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(_password.x, CGRectGetMaxY(_password.frame)+SQ_Fit(30), _password.width, SQ_Fit(48));
        [sureBtn setBackgroundColor:[UIColor getColor:@"fb4142"]];
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
        sureBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //返回登录按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
        button.titleLabel.font = SQ_Font(SQ_Fit(13));
        [button sizeToFit];
        button.center = CGPointMake(SQ_ScreenWidth/2,CGRectGetMaxY(sureBtn.frame)+SQ_Fit(20));
        [button addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
    _password.secureTextEntry = !_password.isSecureTextEntry;
}

-(void)sureButtonAction:(UIButton*)sender{
    [self endEditing:NO];
    if ([sender.titleLabel.text isEqualToString:@"重置密码"]) {
        if (_phoneNum.text.length == 0) {
            [[SQPublicTools sharedPublicTools]showMessage:@"请输入手机号" duration:3];
            return;
        }
        if (_verification.text.length == 0) {
            [[SQPublicTools sharedPublicTools]showMessage:@"请输入手机验证码" duration:3];
            return;
        }
        if (_password.text.length == 0) {
            [[SQPublicTools sharedPublicTools]showMessage:@"请输入登录密码" duration:3];
            return;
        }
        if (![[SQPublicTools sharedPublicTools]judgePhoneNumber:_phoneNum.text]) {
            [[SQPublicTools sharedPublicTools]showMessage:@"您输入的手机号不合法" duration:3];
            return;
        }
        if (![[SQPublicTools sharedPublicTools]judgePassword:_password.text]) {
            [[SQPublicTools sharedPublicTools]showMessage:@"您输入的密码不合法" duration:3];
            return;
        }
    }
    if ([self.delegate respondsToSelector:@selector(forgetView:withSureButton:)]) {
        [self.delegate forgetView:self withSureButton:sender];
    }
}

#pragma mark
#pragma mark 倒计时实现
-(void)verificateButtonClick:(UIButton *)sender{
    
    [[SQPublicTools sharedPublicTools]showMessage:@"验证码已发送至您的手机,请查收" duration:3];
    sender.enabled =NO;
    _count = 60;
    [_verificateBtn setTitle:@"验证码60秒" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [_verificateBtn setTitle:[NSString stringWithFormat:@"验证码%zd秒",_count] forState:UIControlStateDisabled];
    }
    else
    {
        [timer invalidate];
        _verificateBtn.enabled = YES;
        [_verificateBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}
@end
