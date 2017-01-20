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

+ (void)checkReachabilityStatus;

+(instancetype)sharedNetWorkingTools;


/**登录**/
-(void)requestLoginWithPhoneNum:(NSString*)phoneNum withPassword:(NSString *)password callBack:(callBack)callBack;

//加载启动页广告数据
-(void)getLaunchAdvertisementImageDataWithCallBack:(callBack)callBack;
-(void)getLaunchAdvertisementIVideoDataWithCallBack:(callBack)callBack;
@end
