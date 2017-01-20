//
//  SQCertificationCell.m
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQCertificationCell.h"

@interface SQCertificationCell ()

@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) UILabel *detailLab;


@end
@implementation SQCertificationCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleBtn setTitleColor:[UIColor getColor:@"343434"] forState:UIControlStateNormal];
    _titleBtn.adjustsImageWhenHighlighted = NO;
    _titleBtn.titleLabel.font = SQ_Font(SQ_Fit(14));
    _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -SQ_Fit(5), 0, SQ_Fit(5));
    [_titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_titleBtn];
    
    
    _detailLab = [[UILabel alloc]init];
    _detailLab.textColor = [UIColor getColor:@"343434"];
    _detailLab.font = SQ_Font(SQ_Fit(14));
    _detailLab.textAlignment = NSTextAlignmentLeft;
    _detailLab.numberOfLines = 0;
    [self addSubview:_detailLab];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _titleBtn.frame = CGRectMake(0, 0, SQ_Fit(120), self.height);
    _detailLab.frame = CGRectMake(CGRectGetMaxX(_titleBtn.frame), 0,SQ_Fit(150), _titleBtn.height);
    if (self.canSelected) {
        [_titleBtn setImage:[UIImage imageNamed:@"remember-nomal"] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"remember-selected"] forState:UIControlStateSelected];
    }
    
    self.accessoryType = self.canPush?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    self.userInteractionEnabled = self.canPush;

    
    //test
    [_titleBtn setTitle:self.testStr forState:UIControlStateNormal];
    _detailLab.text = self.testDetail;
}

-(void)titleButtonClick:(UIButton*)sender{
    sender.selected = !sender.selected;
}


@end
