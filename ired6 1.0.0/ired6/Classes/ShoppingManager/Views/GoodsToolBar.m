//
//  GoodsToolBar.m
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "GoodsToolBar.h"

@interface GoodsToolBar ()
/**取消*/
@property (nonatomic, strong) UIButton *cancelBtn;
/**确定*/
@property (nonatomic, strong) UIButton *chooseBtn;
@end

@implementation GoodsToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        //取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
        [cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        cancelBtn.frame = CGRectMake(0, 0, SQ_Fit(50), frame.size.height);
        
        //确认按钮
        UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [chooseBtn setTitle:@"确定" forState:UIControlStateNormal];
        [chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        chooseBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
        [chooseBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseBtn];
        chooseBtn.frame = CGRectMake(frame.size.width-SQ_Fit(50), 0, SQ_Fit(50), frame.size.height);

        
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(goodsToolBar:withButtonClick:)]) {
        
        [self.delegate goodsToolBar:self withButtonClick:sender];
    }
}

@end
