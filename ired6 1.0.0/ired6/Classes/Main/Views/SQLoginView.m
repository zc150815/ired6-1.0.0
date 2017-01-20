//
//  SQLoginView.m
//  ired6
//
//  Created by zhangchong on 2017/1/11.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQLoginView.h"
#import "SQTextField.h"
#import "DeformationButton.h"
#import "ZCKeyboard.h"

@interface SQLoginView ()

@property (nonatomic, strong) SQTextField *phoneNum;
@property (nonatomic, strong) SQTextField *verification;
@property (nonatomic, strong) SQTextField *password;

@end
@implementation SQLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    
        //手机号输入框
        _phoneNum = [[SQTextField alloc]init];
        _phoneNum.frame = CGRectMake(SQ_Fit(40), SQ_Fit(20), SQ_ScreenWidth-2*SQ_Fit(40), SQ_Fit(48));
        _phoneNum.leftViewStr = @"手机号";
        _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_phoneNum];
        
        
        //密码输入框
        _password = [[SQTextField alloc]init];
        _password.frame = CGRectMake(_phoneNum.x, CGRectGetMaxY(_phoneNum.frame), _phoneNum.width, _phoneNum.height);
        _password.leftViewStr = @"密    码";
        _password.keyboardType = UIKeyboardTypeDefault;
        _password.secureTextEntry = YES;
        _password.isPassword = YES;
        [self addSubview:_password];
        

        //记住手机号按钮
        UIButton *rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rememberBtn setTitle:@"记住手机号" forState:UIControlStateNormal];
        [rememberBtn setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
        [rememberBtn setImage:[UIImage imageNamed:@"remember-nomal"] forState:UIControlStateNormal];
        [rememberBtn setImage:[UIImage imageNamed:@"remember-selected"] forState:UIControlStateSelected];
        rememberBtn.adjustsImageWhenHighlighted = NO;
        rememberBtn.titleLabel.font = SQ_Font(SQ_Fit(12));
        rememberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, SQ_Fit(10), 0, -SQ_Fit(10));
        [rememberBtn addTarget:self action:@selector(rememberButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [rememberBtn sizeToFit];
        rememberBtn.x = _password.x;
        rememberBtn.y = CGRectGetMaxY(_password.frame)+SQ_Fit(15);
        [self addSubview:rememberBtn];

        //忘记密码按钮
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [forgetBtn setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
        forgetBtn.adjustsImageWhenHighlighted = NO;
        forgetBtn.titleLabel.font = SQ_Font(SQ_Fit(12));
        [forgetBtn addTarget:self action:@selector(forgetRegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [forgetBtn sizeToFit];
        forgetBtn.x = CGRectGetMaxX(_password.frame)-forgetBtn.width;
        forgetBtn.y = rememberBtn.y;
        forgetBtn.height = rememberBtn.height;
        [self addSubview:forgetBtn];
        
        //登录按钮
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setBackgroundColor:[UIColor getColor:@"fb4142"]];
        [sureBtn setTitle:@"登录" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor getColor:@"FFFFFF"] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = SQ_Font(SQ_Fit(16));
        sureBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.frame = CGRectMake(_password.x, CGRectGetMaxY(rememberBtn.frame)+SQ_Fit(30), _password.width, SQ_Fit(48));
        
        
        //注册按钮
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [registerBtn setBackgroundColor:[UIColor getColor:@"f2f2f2"]];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor getColor:@"343434"] forState:UIControlStateNormal];
        registerBtn.titleLabel.font = SQ_Font(SQ_Fit(16));
        registerBtn.adjustsImageWhenHighlighted = NO;
        registerBtn.layer.borderWidth = SQ_Fit(1);
        registerBtn.layer.borderColor = [UIColor getColor:@"CCCCCC"].CGColor;
        [self addSubview:registerBtn];
        [registerBtn addTarget:self action:@selector(forgetRegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        registerBtn.frame = CGRectMake(sureBtn.x, CGRectGetMaxY(sureBtn.frame)+SQ_Fit(15), sureBtn.width, sureBtn.height);
        
    }
    return self;
}

-(void)loginButtonAction:(DeformationButton*)sender{
    
    if (_phoneNum.text.length == 0) {
        [[SQPublicTools sharedPublicTools]showMessage:@"请输入手机号" duration:3];
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
    
    [UIView animateWithDuration:1 animations:^{
        [((UINavigationController*)((UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController) popViewControllerAnimated:YES];
    } completion:^(BOOL finished) {
        [[SQPublicTools sharedPublicTools]loginWithUserID:@"zhangchong"];
        [[SQPublicTools sharedPublicTools]showMessage:@"登陆成功" duration:3];
    }];
}
-(void)rememberButtonClick:(UIButton*)sender{
    sender.selected = !sender.selected;
}
-(void)forgetRegisterBtnClick:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(loginView:withButtonClick:)]) {
        [self.delegate loginView:self withButtonClick:sender];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
