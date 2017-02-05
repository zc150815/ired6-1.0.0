//
//  SQMyOrderView.m
//  SQ565
//
//  Created by zhangchong on 16/12/13.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import "SQMyOrderView.h"
#import "SQMyOrderButton.h"


@implementation SQMyOrderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    NSArray *imageArr = @[@"fragment_my_payment",@"fragment_my_dfh",@"fragment_my_receiving",@"fragment_my_evaluate",@"fragment_my_refund"];
    NSArray *labelArr = @[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"];
    for (NSInteger i = 0; i < 5; i++) {
        CGFloat btnWidth = SQ_ScreenWidth/5;
        CGFloat btnHeight = SQ_Fit(60);
        
        SQMyOrderButton *btn = [[SQMyOrderButton alloc]initWithFrame:CGRectMake(btnWidth*i, 0, btnWidth, btnHeight)];
        [btn setTitle:[NSString stringWithFormat:@"%@",labelArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]] forState:UIControlStateNormal];
        btn.titleLabel.font = SQ_Font(SQ_Fit(12));
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.tag = 1001+i;
        [btn addTarget:self action:@selector(myOrderButtonActiton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)myOrderButtonActiton:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(myOrderView:myOrderButtonActiton:)]) {
        [self.delegate myOrderView:self myOrderButtonActiton:sender];
    }
}


@end
