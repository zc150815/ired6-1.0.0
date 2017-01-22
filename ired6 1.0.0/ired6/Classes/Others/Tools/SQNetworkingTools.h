//
//  SQNetworkingTools.h
//  SQ565
//
//  Created by zhangchong on 16/12/5.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

//#import <AFNetworking/AFNetworking.h>

#import <UIKit/UIKit.h>
#import <AFNetworking.h>


typedef enum : NSUInteger {
    GET = 0,
    POST = 1,
} RequestType;

typedef void (^callBack)(NSDictionary* response,NSError* error);

@interface SQNetworkingTools : AFHTTPSessionManager

//网路状态判断
+ (void)checkReachabilityStatus;

+(instancetype)sharedNetWorkingTools;

#pragma mark
#pragma mark 加载启动页广告数据
-(void)getLaunchAdvertisementImageDataWithCallBack:(callBack)callBack;
-(void)getLaunchAdvertisementIVideoDataWithCallBack:(callBack)callBack;

#pragma mark
#pragma mark 网络数据获取
//认证管理页房屋认证数据列表
-(void)getAttestListHouseDataWithCallBack:(callBack)callBack;
//认证管理页身份认证数据列表
-(void)getAttestListIdentityDataWithCallBack:(callBack)callBack;
//房屋认证数据详情
-(void)getHousingCertificationDataWithCallBack:(callBack)callBack;
//身份认证数据详情
-(void)getIdentityCertificationDataWithCallBack:(callBack)callBack;
@end
