//
//  GridListModel.h
//  列表网格视图切换
//
//  Created by zhangchong on 2016/12/20.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridListModel : NSObject
@property (nonatomic, strong) NSString *imageurl;
@property (nonatomic, strong) NSString *wname;
@property (nonatomic, assign) float jdPrice;
@property (nonatomic, assign) int totalCount;

@end
