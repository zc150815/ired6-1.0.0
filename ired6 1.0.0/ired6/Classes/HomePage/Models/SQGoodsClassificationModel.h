//
//  SQGoodsClassificationModel.h
//  ired6
//
//  Created by zhangchong on 2017/2/7.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQGoodsClassificationModel : NSObject

@property (nonatomic,copy) NSString *FirstName;
//@property (nonatomic, strong) SQGoodsClassificationModel *FirstCategory;
@property (nonatomic, strong) NSArray *FirstCategory;


@property (nonatomic,copy) NSString *SubName;
//@property (nonatomic, strong) SQGoodsClassificationModel *SubCategory;
@property (nonatomic, strong) NSArray *SubCategory;


@property (nonatomic,copy) NSString *ThirdName;
//@property (nonatomic, strong) SQGoodsClassificationModel *ThirdCategory;
@property (nonatomic, strong) NSString *ThirdCategory;


@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) CGFloat rowHeight;

@end
