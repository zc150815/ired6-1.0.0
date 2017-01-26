//
//  SQIdentityMemberCell.m
//  ired6
//
//  Created by zhangchong on 2017/1/26.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQIdentityMemberCell.h"
#import "SQCertificationModel.h"


@interface SQIdentityMemberCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UITextField *textField;


@end
@implementation SQIdentityMemberCell

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
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.textColor = [UIColor getColor:@"343434"];
    _titleLab.font = SQ_Font(SQ_Fit(15));
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    [self addSubview:_titleLab];
    
    _detailLab = [[UILabel alloc]init];
    _detailLab.textColor = [UIColor getColor:@"343434"];
    _detailLab.font = SQ_Font(SQ_Fit(15));
    _detailLab.textAlignment = NSTextAlignmentLeft;
    _detailLab.numberOfLines = 0;
    
    _textField = [[UITextField alloc]init];
    _textField.textColor = [UIColor getColor:@"343434"];
    _textField.font = SQ_Font(SQ_Fit(15));
    _textField.textColor = [UIColor getColor:@"343434"];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLab.frame = CGRectMake(SQ_Fit(15), 0, SQ_Fit(100), self.height);
    _detailLab.frame = CGRectMake(CGRectGetMaxX(_titleLab.frame), 0,self.contentView.width-CGRectGetMaxX(_titleLab.frame), _titleLab.height);
    _textField.frame = CGRectMake(CGRectGetMaxX(_titleLab.frame), 0,self.contentView.width-CGRectGetMaxX(_titleLab.frame), _titleLab.height);
}
-(void)setModel:(SQCertificationModel *)model{
    _model = model;
    
    _titleLab.text = model.item;
    
    if (model.show) {
        [self addSubview:_detailLab];
        _detailLab.text = model.detail;
    }else{
        [self addSubview:_textField];
        _textField.placeholder = @"哈哈哈哈哈哈";
    }
    
}
@end
