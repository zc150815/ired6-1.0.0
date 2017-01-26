//
//  AppDelegate+SQLaunchAd.m
//  ired6
//
//  Created by zhangchong on 2017/1/18.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "AppDelegate+SQLaunchAd.h"
#import "XHLaunchAd.h"
#import "LaunchAdModel.h"

@implementation AppDelegate (SQLaunchAd)
-(void)setupLaunchAd{
    
    [self getLaunchAd_imageAd_networkData];
}

#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)getLaunchAd_imageAd_networkData
{
    //等待时间
    [XHLaunchAd setWaitDataDuration:3];
    [[SQNetworkingTools sharedNetWorkingTools]getLaunchAdvertisementImageDataWithCallBack:^(id response, NSError *error) {
        
        if (error) {
            return ;
        }
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)response;
            
            //广告数据转模型
            LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:dic[@"data"]];
            //配置广告数据
            XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
            //广告停留时间
            imageAdconfiguration.duration = model.duration;
            //广告frame
            imageAdconfiguration.frame = CGRectMake(0, 0, SQ_ScreenWidth, (SQ_ScreenWidth/model.width)*model.height);
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageNameOrURLString = model.content;
            //缓存机制(仅对网络图片有效)
            imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
            //图片填充模式
            imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
            //广告点击打开链接
            imageAdconfiguration.openURLString = model.openUrl;
            //广告显示完成动画
            imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
            //跳过按钮类型
            imageAdconfiguration.skipButtonType = SkipTypeTimeText;
            //后台返回时,是否显示广告
            imageAdconfiguration.showEnterForeground = NO;
            
            //显示开屏广告
            [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        }

    }];
    
}
@end
