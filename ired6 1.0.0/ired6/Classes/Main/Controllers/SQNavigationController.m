//
//  SQNavigationController.m
//  SQ565
//
//  Created by zhangchong on 16/12/5.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import "SQNavigationController.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
#import <Photos/Photos.h>
#import "SQLocationViewController.h"
@interface SQNavigationController ()<SQLocationViewControllerDelegate>
@property (nonatomic, strong) UIButton *locationBarButton;

@end

@implementation SQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationFinished) name:@"LocationFinishedNotification" object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:CommunityName]) {
        [self.locationBarButton setTitle:[defaults objectForKey:CommunityName] forState:UIControlStateNormal];
        [self.locationBarButton sizeToFit];
        return;
    }
    [[SQPublicTools sharedPublicTools]startLocation];
    
}
+(void)initialize{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor getColor:@"fb4142"];
    bar.translucent = NO;
    bar.shadowImage = [UIImage alloc];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor getColor:@"FFFFFF"],
                                NSFontAttributeName:SQ_Font(17)};
//    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        //返回按钮
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [leftButton sizeToFit];
        leftButton.adjustsImageWhenHighlighted = NO;
        [leftButton addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        viewController.hidesBottomBarWhenPushed = YES;
        
    }else{
        //扫一扫按钮
        UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [scanButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [scanButton sizeToFit];
        scanButton.adjustsImageWhenHighlighted = NO;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:scanButton];
        [scanButton addTarget:self action:@selector(scanButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //消息按钮
        UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [messageButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [messageButton sizeToFit];
        messageButton.adjustsImageWhenHighlighted = NO;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:messageButton];
        [messageButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //地址按钮
        UIButton *locationBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [locationBarButton setImage:[UIImage imageNamed:@"jwh_address"] forState:UIControlStateNormal];
        [self.locationBarButton setTitle:@"定位中..." forState:UIControlStateNormal];
        [locationBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        locationBarButton.titleLabel.font = SQ_Font(15);
        [locationBarButton sizeToFit];
        locationBarButton.adjustsImageWhenHighlighted = NO;
        viewController.navigationItem.titleView = locationBarButton;
        [locationBarButton addTarget:self action:@selector(locationBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.locationBarButton = locationBarButton;
    }
    [super pushViewController:viewController animated:animated];
    
}
-(void)popController{
    [self popViewControllerAnimated:YES];
}
//修改状态栏样式
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    [super preferredStatusBarStyle];
    
    return UIStatusBarStyleLightContent;
}
-(void)locationView:(SQLocationViewController *)locationView withLocationStr:(NSString *)locationStr{
    
    [self.locationBarButton setTitle:locationStr forState:UIControlStateNormal];
    [self.locationBarButton sizeToFit];
}


-(void)locationFinished{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:CommunityName]) {
        [self.locationBarButton setTitle:[defaults objectForKey:CommunityName] forState:UIControlStateNormal];
        [self.locationBarButton sizeToFit];
        return;
    }
    [self.locationBarButton setTitle:[defaults objectForKey:DetailAddress] forState:UIControlStateNormal];
    [self.locationBarButton sizeToFit];
}
#pragma mark
#pragma mark 按钮点击事件
//扫一扫
-(void)scanButtonClick{
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
//            NSLog(@"因为系统原因, 无法访问相册");
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 照片 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
            [self pushViewController:scanningQRCodeVC animated:YES];
        } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                }
            }];
        }
        
    } else {
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
    
}
//定位地址
-(void)locationBarButtonClick:(UIButton*)sender{
    
    SQLocationViewController *locationVC = [[SQLocationViewController alloc]init];
    locationVC.delegate = self;
    [self pushViewController:locationVC animated:YES];
}
//消息列表
-(void)messageButtonClick:(UIButton*)sender{
    SQ_NSLog(@"消息列表");
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
@end
