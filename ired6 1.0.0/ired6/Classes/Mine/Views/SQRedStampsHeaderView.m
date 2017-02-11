//
//  SQRedStampsHeaderView.m
//  ired6
//
//  Created by zhangchong on 2017/1/29.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQRedStampsHeaderView.h"

@interface SQRedStampsHeaderView ()

@property (nonatomic, strong) UIButton *ruleBtn;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *numberLab;



@end
@implementation SQRedStampsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.text = @"红票总额(元)";
    _titleLab.font = SQ_Font(SQ_Fit(15));
    _titleLab.textColor = [UIColor whiteColor];
    [_titleLab sizeToFit];
    [self addSubview:_titleLab];
    _titleLab.x = SQ_Fit(15);
    _titleLab.y = SQ_Fit(15);
    
    
    _ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ruleBtn setTitle:@"红票规则" forState:UIControlStateNormal];
    [_ruleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ruleBtn setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    _ruleBtn.titleLabel.font = SQ_Font(SQ_Fit(13));
    _ruleBtn.adjustsImageWhenHighlighted = NO;
    [_ruleBtn sizeToFit];
    _ruleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_ruleBtn.imageView.width, 0, _ruleBtn.imageView.width);
    _ruleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _ruleBtn.titleLabel.width, 0, -_ruleBtn.titleLabel.width);
    [self addSubview:_ruleBtn];
    [_ruleBtn addTarget:self action:@selector(ruleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _ruleBtn.centerY = _titleLab.centerY;
    _ruleBtn.x = SQ_ScreenWidth-_ruleBtn.width-SQ_Fit(15);
    
    
    _numberLab = [[UILabel alloc]init];
    _numberLab.text = @"140";
    _numberLab.font = SQ_Font(SQ_Fit(30));
    _numberLab.textColor = [UIColor whiteColor];
    [_numberLab sizeToFit];
    [self addSubview:_numberLab];
    _numberLab.x = _titleLab.x;
    _numberLab.y = CGRectGetMaxY(_titleLab.frame)+SQ_Fit(20);
    
    
    NSArray *array1 = @[@"今年总获取",@"今年帮你省",@"抵用订单数"];
    NSArray *array2 = @[@"100",@"50",@"5"];
    for (NSInteger i = 0; i < array1.count; i++) {
        UIView *BtnView = [[UIView alloc]init];
        BtnView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
        CGFloat viewWith = SQ_ScreenWidth/array1.count;
        BtnView.frame = CGRectMake(i*viewWith, SQ_Fit(100), viewWith, SQ_Fit(50));
        BtnView.tag = 1000+i;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewBtnClick:)];
        [BtnView addGestureRecognizer:tapGesture];
        [self addSubview:BtnView];
        
        UILabel *BtnTitle = [[UILabel alloc]init];
        BtnTitle.textColor = [UIColor whiteColor];
        BtnTitle.text = array1[i];
        BtnTitle.font = SQ_Font(SQ_Fit(13));
        BtnTitle.textAlignment = NSTextAlignmentCenter;
        BtnTitle.frame = CGRectMake(0, 0, BtnView.width, BtnView.height/2);
        [BtnView addSubview:BtnTitle];
        
        UILabel *BtnNumber = [[UILabel alloc]init];
        BtnNumber.textColor = [UIColor whiteColor];
        BtnNumber.text = array2[i];
        BtnNumber.font = SQ_Font(SQ_Fit(13));
        BtnNumber.textAlignment = NSTextAlignmentCenter;
        BtnNumber.frame = CGRectMake(0, BtnView.height/2, BtnView.width, BtnView.height/2);
        [BtnView addSubview:BtnNumber];
        
    }
}
-(void)ruleButtonClick:(UIButton*)sender{
    
    
}
-(void)viewBtnClick:(UITapGestureRecognizer*)tapGesture{
    
    UIView *BtnView = tapGesture.view;
    
    SQ_NSLog(@"%zd",BtnView.tag);
    
}
@end
