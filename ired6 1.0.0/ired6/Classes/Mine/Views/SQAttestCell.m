//
//  SQAttestCell.m
//  ired6
//
//  Created by zhangchong on 2017/1/20.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQAttestCell.h"
#import "SQAttestListModel.h"

@interface SQAttestCell ()

@property (nonatomic, strong) UIImageView *stateView;//认证状态
@property (nonatomic, strong) UILabel *titleStrLab; //首行内容
@property (nonatomic, strong) UILabel *detailStrLab;//次行内容
@property (nonatomic, strong) UILabel *additionalStrLab;//补充内容
@property (nonatomic, strong) UILabel *attestedNumLab;//认证数量




@end
@implementation SQAttestCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, 1)];
    line.backgroundColor = [UIColor getColor:@"f2f2f2"];
    [self.contentView addSubview:line];
    
    _stateView = [[UIImageView alloc]initWithFrame:CGRectMake(SQ_Fit(15), SQ_Fit(15), SQ_Fit(18), SQ_Fit(18))];
    [self.contentView addSubview:_stateView];
    
    _titleStrLab = [[UILabel alloc]init];
    _titleStrLab.font = SQ_Font(SQ_Fit(15));
    _titleStrLab.textColor = [UIColor getColor:@"343434"];
    [self.contentView addSubview:_titleStrLab];
    
    _detailStrLab = [[UILabel alloc]init];
    _detailStrLab.font = SQ_Font(SQ_Fit(13));
    _detailStrLab.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:_detailStrLab];
    
    _additionalStrLab = [[UILabel alloc]init];
    _additionalStrLab.font = SQ_Font(SQ_Fit(13));
    _additionalStrLab.textColor = [UIColor getColor:@"888888"];
    [self.contentView addSubview:_additionalStrLab];

    _attestedNumLab = [[UILabel alloc]init];
    _attestedNumLab.font = _additionalStrLab.font;
    _attestedNumLab.textColor = _additionalStrLab.textColor;
    [self.contentView addSubview:_attestedNumLab];

}
-(void)layoutSubviews{
    [super layoutSubviews];
        _attestedNumLab.x = SQ_ScreenWidth*2/3;
    _attestedNumLab.y = _additionalStrLab.y;
}
-(void)setModel:(SQAttestListModel *)model{
    _model = model;
    
    _stateView.image = [UIImage imageNamed:model.isAttested.integerValue?@"isAttested":@"isNotAttested"];
    
    _titleStrLab.text = model.titleStr;
    [_titleStrLab sizeToFit];
    _titleStrLab.x = CGRectGetMaxX(_stateView.frame)+SQ_Fit(12);
    _titleStrLab.y = _stateView.y;
    
    if (model.detailStr) {
        _detailStrLab.hidden = NO;
        _detailStrLab.text = model.detailStr;
        [_detailStrLab sizeToFit];
        _detailStrLab.x = _titleStrLab.x;
        _detailStrLab.y = CGRectGetMaxY(_titleStrLab.frame) + SQ_Fit(15);
        _additionalStrLab.text = model.additionalStr;
        [_additionalStrLab sizeToFit];
        _additionalStrLab.x = _detailStrLab.x;
        _additionalStrLab.y = CGRectGetMaxY(_detailStrLab.frame) + SQ_Fit(12);
    }else{
        _detailStrLab.hidden = YES;
        _additionalStrLab.text = model.additionalStr;
        [_additionalStrLab sizeToFit];
        _additionalStrLab.x = _detailStrLab.x;
        _additionalStrLab.y = CGRectGetMaxY(_titleStrLab.frame) + SQ_Fit(15);
    }
    
    if (model.attestedNum) {
        _attestedNumLab.hidden = NO;
        _attestedNumLab.text = [NSString stringWithFormat:@"已认证用户:%zd人",model.attestedNum.integerValue];
        [_attestedNumLab sizeToFit];
    }else{
        _attestedNumLab.hidden = YES;
    }
}
@end
