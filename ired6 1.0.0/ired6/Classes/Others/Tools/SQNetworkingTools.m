//
//  SQNetworkingTools.m
//  SQ565
//
//  Created by zhangchong on 16/12/5.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import "SQNetworkingTools.h"

@implementation SQNetworkingTools

+ (void)checkReachabilityStatus{
    
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            [[SQPublicTools sharedPublicTools]showMessage:@"网络连接错误，请检查您的网络！" duration:3];
            return ;
        }else if (status==AFNetworkReachabilityStatusReachableViaWWAN){
            [[SQPublicTools sharedPublicTools]showMessage:@"正在使用移动数据" duration:3];
        }else if (status==AFNetworkReachabilityStatusReachableViaWiFi){
            [[SQPublicTools sharedPublicTools]showMessage:@"正在使用WIFI" duration:3];
        }
    }];
}
//MARK: 单例创建对象
static id _instanceType;
+(instancetype)sharedNetWorkingTools
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[self alloc]init];
    });
    
    return _instanceType;
}
 
/**
 *  封装get/post请求
 *
 *  @param type     请求类型
 *  @param url      请求地址
 *  @param params   请求参数
 *  @param callBack 回调block
 */
-(void)requestWithRequestType:(RequestType)type url:(NSString*)url params:(NSDictionary*)params callBack:(callBack)callBack {
    
    if (type == GET) {
        
        [[AFHTTPSessionManager manager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            callBack(responseObject,nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            callBack(nil,error);
        }];
        
    }else{
        [[AFHTTPSessionManager manager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            callBack(responseObject,nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            callBack(nil,error);
        }];
    }
}
#pragma mark
#pragma 加载启动页广告数据
-(void)getLaunchAdvertisementImageDataWithCallBack:(callBack)callBack{
    
//    NSString*url = @"";
//    NSDictionary *params = @{};
//    [self requestWithRequestType:GET url:url params:params callBack:callBack];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LaunchImageAd" ofType:@"json"]];
        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        callBack(json,nil);
    });

}
-(void)getLaunchAdvertisementIVideoDataWithCallBack:(callBack)callBack{
    
    NSString*url = @"";
    NSDictionary *params = @{};
    [self requestWithRequestType:GET url:url params:params callBack:callBack];
}
#pragma mark
#pragma mark 网络数据获取
//认证管理页房屋认证数据列表
-(void)getAttestListHouseDataWithCallBack:(callBack)callBack{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AttestListHouse" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        callBack(dic,nil);
    });
}
//认证管理页身份认证数据列表
-(void)getAttestListIdentityDataWithCallBack:(callBack)callBack{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AttestListIdentity" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        callBack(dic,nil);
    });

}
//房屋认证数据详情
-(void)getHousingCertificationDataWithCallBack:(callBack)callBack{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HousingCertification" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        callBack(dic,nil);
    });
}
//身份认证数据详情
-(void)getIdentityCertificationDataWithCallBack:(callBack)callBack{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"IdentityCertification" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        callBack(dic,nil);
    });
}
@end
