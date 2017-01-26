//
//  SQHouseCertificationModel.h
//  ired6
//
//  Created by zhangchong on 2017/1/22.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQCertificationModel;
@interface SQHouseCertificationModel : NSObject

@property (nonatomic,copy) NSString *item;//leg:家有老人
@property (nonatomic,strong) NSArray *detailArr;//leg:家有老人列表

@property (nonatomic,assign) BOOL canSelected;
@property (nonatomic,assign) BOOL show;


@end
