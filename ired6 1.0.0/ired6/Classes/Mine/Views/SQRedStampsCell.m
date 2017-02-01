//
//  SQRedStampsCell.m
//  ired6
//
//  Created by zhangchong on 2017/1/26.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQRedStampsCell.h"
#import "SQRedStampsModel.h"

@interface SQRedStampsCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *detailLab;

@end
@implementation SQRedStampsCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, 1)];
    line.backgroundColor = [UIColor getColor:@"f2f2f2"];
    [self addSubview:line];
    
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(SQ_Fit(15), SQ_Fit(12), SQ_Fit(24), SQ_Fit(24))];
    [self addSubview:_iconView];
    
    _detailLab = [[UILabel alloc]init];
    _detailLab.font = SQ_Font(SQ_Fit(15));
    _detailLab.textColor = [UIColor getColor:@"343434"];
    [self addSubview:_detailLab];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _detailLab.x = CGRectGetMaxX(_iconView.frame)+SQ_Fit(12);
    _detailLab.centerY = _iconView.centerY;
}

-(void)setModel:(SQRedStampsModel *)model{
    _model = model;
    
    _iconView.image = [UIImage imageNamed:model.itemImage];
    _detailLab.text = model.itemStr;
    [_detailLab sizeToFit];
}
@end
