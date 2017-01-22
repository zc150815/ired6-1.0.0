//
//  SQCertificationModel.h
//  ired6
//
//  Created by zhangchong on 2017/1/20.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQCertificationModel : NSObject


@property (nonatomic,copy) NSString *state;//状态
@property (nonatomic,copy) NSString *image;//leg:"identity.png"
@property (nonatomic,copy) NSString *item;//leg:所在小区
@property (nonatomic,copy) NSString *detail;//leg:华澳中心


@property (nonatomic,assign) BOOL canPush;
@property (nonatomic,assign) BOOL canSelected;
@property (nonatomic,assign) BOOL show;









@end
