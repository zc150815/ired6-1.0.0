//
//  SQAttestListModel.h
//  ired6
//
//  Created by zhangchong on 2017/1/20.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQAttestListModel : NSObject

//认证管理首页内容model
@property (nonatomic,copy) NSString *isAttested;    //认证状态
@property (nonatomic,copy) NSString *titleStr;      //首要内容
@property (nonatomic,copy) NSString *detailStr;     //次要内容
@property (nonatomic,copy) NSString *additionalStr; //补充内容
@property (nonatomic,copy) NSString *attestedNum;   //认证数量

//房屋认证内容model



//身份认证内容model







@end
