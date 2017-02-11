//
//  SQThirdCategoryButton.m
//  ired6
//
//  Created by zhangchong on 2017/2/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQThirdCategoryButton.h"

@implementation SQThirdCategoryButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = SQ_Font(SQ_Fit(10));
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}
@end
