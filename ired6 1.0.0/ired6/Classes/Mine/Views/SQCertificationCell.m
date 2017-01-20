//
//  SQCertificationCell.m
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQCertificationCell.h"
#import "SQCertificationModel.h"

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
    _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, SQ_Fit(5), 0, SQ_Fit(5));
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
    
    _titleBtn.frame = CGRectMake(SQ_Fit(15), 0, SQ_Fit(100), self.height);
    
    _detailLab.frame = CGRectMake(CGRectGetMaxX(_titleBtn.frame), 0,self.contentView.width-CGRectGetMaxX(_titleBtn.frame), _titleBtn.height);
}

-(void)titleButtonClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    SQ_NSLog(@"selected = %zd",sender.selected);
}

-(void)setModel:(SQCertificationModel *)model{
    _model = model;
    
    if (model.canSelected) {
        [_titleBtn setImage:[UIImage imageNamed:@"remember-nomal"] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"remember-selected"] forState:UIControlStateSelected];
    }
    [_titleBtn setTitle:model.itemStr forState:UIControlStateNormal];
    if (model.show) {
        _detailLab.text = model.detailStr;
    }
    if (!model.show && self.tag == 1000) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _detailLab.text = [defaults objectForKey:CommunityName];
    }
    self.accessoryType = model.canPush?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    self.userInteractionEnabled = model.canPush;

}
@end
