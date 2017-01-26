//
//  SQAttestListModel.h
//  ired6
//
//  Created by zhangchong on 2017/1/20.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQCertificationModel;
@interface SQAttestListModel : NSObject

//认证管理首页内容model
@property (nonatomic,copy) NSString *isAttested;    //认证状态
@property (nonatomic,copy) NSString *titleStr;      //首要内容
@property (nonatomic,copy) NSString *detailStr;     //次要内容
@property (nonatomic,copy) NSString *additionalStr; //补充内容
@property (nonatomic,copy) NSString *attestedNum;   //认证数量


@property (nonatomic, strong) NSArray *required;//房屋认证房屋信息
@property (nonatomic, strong) NSArray *optional;//房屋认证成员信息

@property (nonatomic, strong) NSArray<SQCertificationModel*> *detail;

@property (nonatomic,copy) NSString *titleImage;//身份认证种类页图标







@end
