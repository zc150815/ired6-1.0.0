//
//  SQCertificationCell.h
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQCertificationModel,SQHouseCertificationModel;
@interface SQHouseCertificationCell : UITableViewCell

@property (nonatomic, strong) SQCertificationModel *infoModel;
@property (nonatomic, strong) SQHouseCertificationModel *memberModel;

@end
