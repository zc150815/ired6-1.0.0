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

@property (nonatomic, strong) UIImageView *stateView;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *detailArressLab;
@property (nonatomic, strong) UILabel *detailStrLab;
@property (nonatomic, strong) UILabel *attestedNumLab;




@end
@implementation SQAttestCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font = SQ_Font(SQ_Fit(15));
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
    
    _addressLab = [[UILabel alloc]init];
    _addressLab.font = SQ_Font(SQ_Fit(15));
    _addressLab.textColor = [UIColor getColor:@"343434"];
    [self.contentView addSubview:_addressLab];
    
    _detailArressLab = [[UILabel alloc]init];
    _detailArressLab.font = SQ_Font(SQ_Fit(13));
    _detailArressLab.textColor = [UIColor getColor:@"333333"];
    [self.contentView addSubview:_detailArressLab];
    
    _detailStrLab = [[UILabel alloc]init];
    _detailStrLab.font = SQ_Font(SQ_Fit(13));
    _detailStrLab.textColor = [UIColor getColor:@"888888"];
    [self.contentView addSubview:_detailStrLab];

    _attestedNumLab = [[UILabel alloc]init];
    _attestedNumLab.font = _detailStrLab.font;
    _attestedNumLab.textColor = _detailStrLab.textColor;
    [self.contentView addSubview:_attestedNumLab];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    _addressLab.x = CGRectGetMaxX(_stateView.frame)+SQ_Fit(12);
    _addressLab.y = _stateView.y;
    _detailArressLab.x = _addressLab.x;
    _detailArressLab.y = CGRectGetMaxY(_addressLab.frame) + SQ_Fit(15);
    _detailStrLab.x = _detailArressLab.x;
    _detailStrLab.y = CGRectGetMaxY(_detailArressLab.frame) + SQ_Fit(12);
    _attestedNumLab.x = SQ_ScreenWidth*2/3;
    _attestedNumLab.y = _detailStrLab.y;
}
-(void)setModel:(SQAttestListModel *)model{
    _model = model;
    
    _stateView.image = [UIImage imageNamed:model.isAttested.integerValue?@"isAttested":@"isNotAttested"];
    _addressLab.text = model.address;
    [_addressLab sizeToFit];
    
    _detailArressLab.text = model.detailAddress;
    [_detailArressLab sizeToFit];
    
    _detailStrLab.text = model.detailStr;
    [_detailStrLab sizeToFit];
    
    _attestedNumLab.text = [NSString stringWithFormat:@"已认证用户:%zd人",model.attestedNum.integerValue];
    [_attestedNumLab sizeToFit];
}
@end
