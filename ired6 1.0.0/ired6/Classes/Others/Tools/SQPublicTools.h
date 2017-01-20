//
//  SQPublicTools.h
//  ired6
//
//  Created by zhangchong on 2017/1/10.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SQPublicTools : NSObject

@property (nonatomic,assign) BOOL isLogin;

+(instancetype)sharedPublicTools;

//登录
-(void)loginWithUserID:(NSString*)userID;
//注销
-(void)logoutWithUserId:(NSString*)userID;
//显示提示框
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time;
//判断手机号
- (BOOL)judgePhoneNumber:(NSString *)phoneNum;
//判断密码
- (BOOL)judgePassword:(NSString *)password;

//开始定位
-(void)startLocation;

@end
