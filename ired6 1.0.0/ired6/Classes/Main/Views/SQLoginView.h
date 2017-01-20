//
//  SQLoginView.h
//  ired6
//
//  Created by zhangchong on 2017/1/11.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQLoginView;
@protocol  SQLoginViewDelegate<NSObject>
-(void)loginView:(SQLoginView*)loginView withButtonClick:(UIButton*)sender;
@end

@interface SQLoginView : UIView
@property (nonatomic, weak) id<SQLoginViewDelegate> delegate;
@end
