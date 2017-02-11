//
//  SQLoginViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQLoginViewController.h"
#import "SQPublicTools.h"
#import "SQRegisterView.h"
#import "SQForgetView.h"
#import "SQLoginView.h"
#import "SQTextField.h"


@interface SQLoginViewController ()<SQRegisterViewDelegate,SQLoginViewDelegate,SQForgetViewDelegate>

@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, strong) SQForgetView *forgetView;
@property (nonatomic, strong) SQLoginView *loginView;
@property (nonatomic, strong) UIScrollView *registerView;





@end

@implementation SQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.mainView.contentOffset = CGPointMake(SQ_ScreenWidth, 0);
    self.title = @"登录";
    
}
-(void)endEditing{
    [self.view endEditing:YES];
}
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];

    _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_ScreenHeight)];
    _mainView.contentSize = CGSizeMake(SQ_ScreenWidth*3, 0);
    _mainView.pagingEnabled = YES;
    _mainView.scrollEnabled = NO;
    [self.view addSubview:_mainView];
    [_mainView addSubview:self.loginView];
}

//忘记密码页面
-(SQForgetView *)forgetView{
    if (!_forgetView) {
        _forgetView = [[SQForgetView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_ScreenHeight)];
        _forgetView.delegate = self;
    }
    return _forgetView;
}

//登录页面
-(SQLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[SQLoginView alloc]initWithFrame:CGRectMake(SQ_ScreenWidth, 0, SQ_ScreenWidth, SQ_ScreenHeight)];
        _loginView.delegate = self;
    }
    return _loginView;
}

//注册页面
-(UIScrollView *)registerView{
    if (!_registerView) {
        _registerView = [[UIScrollView alloc]initWithFrame:CGRectMake(SQ_ScreenWidth*2, 0, SQ_ScreenWidth, SQ_ScreenHeight)];
        _registerView.backgroundColor = [UIColor whiteColor];
        _registerView.scrollEnabled = NO;
        _registerView.pagingEnabled = YES;
        _registerView.contentSize = CGSizeMake(SQ_ScreenWidth*3, 0);
        
        SQRegisterView *registerViewOne = [[SQRegisterView alloc]initWithFrame:CGRectMake(0, 0, _registerView.width,_registerView.height)];
        [_registerView addSubview:registerViewOne];
        registerViewOne.delegate = self;
        registerViewOne.title = @"手机号注册";
        registerViewOne.placeholder = @"请输入手机号";
        registerViewOne.keyboard = UIKeyboardTypeNumberPad;
        registerViewOne.buttonStr = @"下一步";
        
//        SQRegisterView *registerViewTwo = [[SQRegisterView alloc]initWithFrame:CGRectMake(_registerView.width, 0, _registerView.width,_registerView.height)];
//        [_registerView addSubview:registerViewTwo];
//        registerViewTwo.delegate = self;
//        registerViewTwo.title = @"输入验证码";
//        registerViewTwo.placeholder = @"请输入验证码";
//        registerViewTwo.keyboard = UIKeyboardTypeNumberPad;
//        registerViewTwo.buttonStr = @"下一步";
        
//        SQRegisterView *registerViewThree = [[SQRegisterView alloc]initWithFrame:CGRectMake(_registerView.width*2, 0, _registerView.width,_registerView.height)];
//        [_registerView addSubview:registerViewThree];
//        registerViewThree.keyboard = UIKeyboardTypeNamePhonePad;
//        registerViewThree.delegate = self;
//        registerViewThree.placeholder = @"请设置登录密码";
//        registerViewThree.title = @"设置登录密码";
//        registerViewThree.detail = @"密码长度6-16位,只包含字母和数字";
//        registerViewThree.buttonStr = @"注册";
    }
    return _registerView;
}


#pragma mark
#pragma mark 代理方法

//注册页面代理方法
-(void)registerView:(SQRegisterView *)registerView withNextButton:(UIButton *)nextButton{
    if ([nextButton.titleLabel.text isEqualToString:@"返回登录"]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.mainView setContentOffset:CGPointMake(SQ_ScreenWidth, 0) animated:NO];
        } completion:^(BOOL finished) {
            [registerView removeFromSuperview];
            _registerView = nil;
        }];
        return;
    }
    NSString *buttonStr = registerView.title;
    if ([buttonStr isEqualToString:@"手机号注册"]) {
        
        SQRegisterView *registerViewTwo = [[SQRegisterView alloc]initWithFrame:CGRectMake(_registerView.width, 0, _registerView.width,_registerView.height)];
        [_registerView addSubview:registerViewTwo];
        registerViewTwo.delegate = self;
        registerViewTwo.title = @"输入验证码";
        registerViewTwo.placeholder = @"请输入验证码";
        registerViewTwo.keyboard = UIKeyboardTypeNumberPad;
        registerViewTwo.buttonStr = @"下一步";
        registerViewTwo.detail = @"接收验证码需要60秒,请耐心等待";
        
        [UIView animateWithDuration:0.5 animations:^{
            [_registerView setContentOffset:CGPointMake(SQ_ScreenWidth, 0) animated:NO];
        } completion:^(BOOL finished) {
            [[SQPublicTools sharedPublicTools]showMessage:@"验证码已发送至您的手机,请查收" duration:3];
        }];
        return;
    }
    if ([buttonStr isEqualToString:@"输入验证码"]) {
        
        SQRegisterView *registerViewThree = [[SQRegisterView alloc]initWithFrame:CGRectMake(_registerView.width*2, 0, _registerView.width,_registerView.height)];
        [_registerView addSubview:registerViewThree];
        registerViewThree.keyboard = UIKeyboardTypeNamePhonePad;
        registerViewThree.delegate = self;
        registerViewThree.placeholder = @"请设置登录密码";
        registerViewThree.title = @"设置登录密码";
        registerViewThree.detail = @"密码长度6-16位,只包含字母和数字";
        registerViewThree.buttonStr = @"注册";
        
        [UIView animateWithDuration:0.5 animations:^{
            [_registerView setContentOffset:CGPointMake(SQ_ScreenWidth*2, 0) animated:NO];
        }];
        return;
    }
    
    
    //注册最后一步
    if ([nextButton.titleLabel.text isEqualToString:@"注册"]) {
        
        NSString *phoneNumber = [SQPublicTools sharedPublicTools].phoneNumber;
        NSString *password = [SQPublicTools sharedPublicTools].password;

        [[SQNetworkingTools sharedNetWorkingTools]registerWithPhoneNum:phoneNumber Password:password CallBack:^(id response, NSError *error) {
            if (error) {
                [[SQPublicTools sharedPublicTools]showMessage:@"数据获取错误" duration:3];
                return;
            }
            if ([response[@"info"] isEqualToString:@"200"]) {//注册成功
                [UIView animateWithDuration:0.5 animations:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } completion:^(BOOL finished) {
                    [[SQPublicTools sharedPublicTools] showMessage:@"注册成功" duration:3];
                    [[SQPublicTools sharedPublicTools] loginWithUserID:@"zhangchong"];
                }];
            }else{//注册失败
                [[SQPublicTools sharedPublicTools]showMessage:@"账户已存在,请登录" duration:3];
            }

        }];
        
    }
}
//登录页面代理方法
-(void)loginView:(SQLoginView*)loginView withButtonClick:(UIButton*)sender{
    [loginView endEditing:NO];
    if ([sender.titleLabel.text isEqualToString:@"忘记密码?"]) {
        [_mainView addSubview:self.forgetView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.mainView setContentOffset:CGPointMake(0, 0) animated:NO];
        } completion:nil];
        self.title = @"忘记密码";
        return;
    }
    if ([sender.titleLabel.text isEqualToString:@"注册"]){
        [_mainView addSubview:self.registerView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.mainView setContentOffset:CGPointMake(SQ_ScreenWidth*2, 0) animated:NO];
        } completion:nil];
        self.title = @"注册";
        return;
    }
}
//忘记密码页面代理方法
-(void)forgetView:(SQForgetView*)forgetView withSureButton:(UIButton*)sender;{
    
    if ([sender.titleLabel.text isEqualToString:@"返回登录"]){
        [UIView animateWithDuration:0.5 animations:^{
            [self.mainView setContentOffset:CGPointMake(SQ_ScreenWidth, 0) animated:NO];
        } completion:^(BOOL finished) {
            [forgetView removeFromSuperview];
            _forgetView = nil;
        }];
    }
    self.title = @"登录";
}
@end
