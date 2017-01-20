//
//  SQCertificationCell.h
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQCertificationCell : UITableViewCell


@property (nonatomic,assign) BOOL canSelected;

@property (nonatomic,assign) BOOL canPush;


@property (nonatomic,copy) NSString *testStr;
@property (nonatomic,copy) NSString *testDetail;

@end
