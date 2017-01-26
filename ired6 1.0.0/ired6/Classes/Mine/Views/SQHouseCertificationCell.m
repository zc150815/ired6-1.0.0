//
//  SQCertificationCell.m
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQHouseCertificationCell.h"
#import "SQCertificationModel.h"
#import "SQHouseCertificationModel.h"


@interface SQHouseCertificationCell ()

@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) UILabel *detailLab;


@end
@implementation SQHouseCertificationCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, 1)];
    line.backgroundColor = [UIColor getColor:@"f2f2f2"];
    [self addSubview:line];
    
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


-(void)setInfoModel:(SQCertificationModel *)infoModel{
    _infoModel = infoModel;
    [_titleBtn setTitle:infoModel.item forState:UIControlStateNormal];
    if (infoModel.show) {
        _detailLab.text = infoModel.detail;
    }
    if (!infoModel.show && self.tag == 1000) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _detailLab.text = [defaults objectForKey:CommunityName];
    }
    self.accessoryType = infoModel.canPush?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    self.userInteractionEnabled = infoModel.canPush;

}
-(void)setMemberModel:(SQHouseCertificationModel *)memberModel{
    _memberModel = memberModel;
    
    if (memberModel.canSelected) {
        [_titleBtn setImage:[UIImage imageNamed:@"remember-nomal"] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"remember-selected"] forState:UIControlStateSelected];
    }
    [_titleBtn setTitle:memberModel.item forState:UIControlStateNormal];
    if (memberModel.show) {
        _detailLab.text = [NSString stringWithFormat:@"%zd",[memberModel.detailArr count]];
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.userInteractionEnabled = YES;
    
}

@end
