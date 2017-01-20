//
//  SQRegisterView.m
//  ired6
//
//  Created by zhangchong on 2017/1/11.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQRegisterView.h"
#import "SQTextField.h"
#import "ZCKeyboard.h"

@interface SQRegisterView ()
@property (nonatomic, strong) SQTextField *textField;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *detailLab;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *returnBtn;

@property (nonatomic,assign) NSInteger count;


@end
@implementation SQRegisterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = SQ_Font(SQ_Fit(26));
        _titleLab.textColor = [UIColor getColor:@"343434"];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        
        
        _textField = [[SQTextField alloc]init];
        _textField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textField];
        
        _detailLab = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailLab setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
        _detailLab.titleLabel.font = SQ_Font(SQ_Fit(12));
        [self addSubview:_detailLab];
        [_detailLab addTarget:self action:@selector(countClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setBackgroundColor:[UIColor getColor:@"fb4142"]];
        [_nextBtn addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
        [self addSubview:_nextBtn];
        
        //返回登录按钮
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setTitle:@"返回登录" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
        _returnBtn.titleLabel.font = SQ_Font(SQ_Fit(13));
        [_returnBtn sizeToFit];
        [_returnBtn addTarget:self action:@selector(returnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnBtn];
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //标题
    [_titleLab sizeToFit];
    _titleLab.centerX = SQ_ScreenWidth/2;
    _titleLab.y = SQ_Fit(90);
    
    //文本输入框
    _textField.keyboardType = self.keyboard;
    if ([self.title isEqualToString:@"输入验证码"]) {
        _textField.inputView = [ZCKeyboard keyboardWithTextField:_textField];
        [self performSelector:@selector(countClick) withObject:nil];
    }
    _textField.frame = CGRectMake(SQ_Fit(40), CGRectGetMaxY(_titleLab.frame)+SQ_Fit(50), SQ_ScreenWidth-2*SQ_Fit(40), SQ_Fit(48));
    
    //说明文本
    if (self.detail) {
        [_detailLab sizeToFit];
        _detailLab.width = _textField.width;
        _detailLab.centerX = SQ_ScreenWidth/2;
        _detailLab.y = CGRectGetMaxY(_textField.frame)+SQ_Fit(15);
    }
    
    //点击下一步
    _nextBtn.frame = CGRectMake(_textField.x, CGRectGetMaxY(_textField.frame)+SQ_Fit(65), _textField.width, SQ_Fit(48));
    [_nextBtn setTitle:_buttonStr forState:UIControlStateNormal];
   
    //返回登录按钮
    _returnBtn.center = CGPointMake(SQ_ScreenWidth/2,CGRectGetMaxY(_nextBtn.frame)+SQ_Fit(20));
    
    
    if ([_title isEqualToString:@"设置登录密码"]) {
        _textField.isPassword = YES;
        _textField.secureTextEntry = YES;
    }
    
}

#pragma mark
#pragma mark 按钮方法实现

-(void)nextButtonClick:(UIButton*)sender{
    [self endEditing:NO];
    if ([_title isEqualToString:@"手机号注册"]){
        if (_textField.text.length == 0||![[SQPublicTools sharedPublicTools]judgePhoneNumber:_textField.text]) {
            [[SQPublicTools sharedPublicTools]showMessage:@"请输入正确的手机号" duration:3];
            return;
        }
    }
    if ([_title isEqualToString:@"输入验证码"]){
        if (_textField.text.length == 0) {
            [[SQPublicTools sharedPublicTools]showMessage:@"请输入正确的手机验证码" duration:3];
            return;
        }
    }
    if ([_title isEqualToString:@"设置登录密码"]) {
        if (_textField.text.length == 0 || ![[SQPublicTools sharedPublicTools] judgePassword:_textField.text]) {
            [[SQPublicTools sharedPublicTools]showMessage:@"请输入正确的登录密码" duration:3];
            return;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(registerView:withNextButton:)]) {
        [self.delegate registerView:self withNextButton:sender];
    }
}

-(void)returnButtonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(registerView:withNextButton:)]) {
        [self.delegate registerView:self withNextButton:sender];
    }
}

#pragma mark
#pragma mark 倒计时实现
-(void)countClick
{
    _detailLab.enabled =NO;
    _count = 60;
    [_detailLab setTitle:self.detail forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [_detailLab setTitle:[NSString stringWithFormat:@"接收验证码需要%zd秒,请耐心等待!",_count] forState:UIControlStateDisabled];
    }
    else
    {
        [timer invalidate];
        _detailLab.enabled = YES;
        [_detailLab setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    }
}

#pragma mark
#pragma mark setter方法实现
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLab.text = title;
}
-(void)setDetail:(NSString *)detail{
    _detail = detail;
    [_detailLab setTitle:detail forState:UIControlStateNormal];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
