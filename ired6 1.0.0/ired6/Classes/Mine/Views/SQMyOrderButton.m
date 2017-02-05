//
//  SQVerticalButton.m
//  SQ565
//
//  Created by zhangchong on 16/12/5.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import "SQMyOrderButton.h"

@implementation SQMyOrderButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = (self.width-SQ_Fit(25))/2;
    self.imageView.y = SQ_Fit(SQ_BaseMargin);
    self.imageView.width = SQ_Fit(25);
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}



@end
