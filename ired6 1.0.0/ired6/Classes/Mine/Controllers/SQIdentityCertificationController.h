//
//  SQIdentityCertificationController.h
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQAttestListModel;
@interface SQIdentityCertificationController : UITableViewController

@property (nonatomic,assign) BOOL canEdit;
@property (nonatomic, strong) SQAttestListModel *model;

@end
