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

typedef void (^callBack)(id response,NSError* error);

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
//新增身份认证种类列表数据
-(void)getNewIdentityClassDataWithCallBack:(callBack)callBack;
//红票列表数据
-(void)getRedStampsDataWithCallBack:(callBack)callBack;
//猜你喜欢数据
-(void)getGuessYouLikeDataWithCallBack:(callBack)callBack;
//购物车数据
-(void)getShoppingCartDataWithCallBack:(callBack)callBack;

#pragma mark
#pragma mark 登录注册
-(void)loginWithPhoneNum:(NSString*)phoneNum Password:(NSString*)password CallBack:(callBack)callBack;
-(void)registerWithPhoneNum:(NSString*)phoneNum Password:(NSString*)password CallBack:(callBack)callBack;
@end
