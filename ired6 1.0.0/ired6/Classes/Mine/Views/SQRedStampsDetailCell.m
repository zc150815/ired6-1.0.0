//
//  SQRedStampsDetailCell.m
//  ired6
//
//  Created by zhangchong on 2017/1/30.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQRedStampsDetailCell.h"
#import "SQRedStampsDetailsModel.h"

@interface SQRedStampsDetailCell ()
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *timeLab;



@end
@implementation SQRedStampsDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, 1)];
    line.backgroundColor = [UIColor getColor:@"f2f2f2"];
    [self.contentView addSubview:line];
    
    _typeLab = [[UILabel alloc]init];
    _typeLab.font = SQ_Font(SQ_Fit(14));
    _typeLab.textColor = [UIColor getColor:@"343434"];
    [self.contentView addSubview:_typeLab];
    
    _numLab = [[UILabel alloc]init];
    _numLab.font = SQ_Font(SQ_Fit(15));
    _numLab.textColor = [UIColor getColor:@"34b800"];
    _numLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_numLab];
    
    _timeLab = [[UILabel alloc]init];
    _timeLab.font = SQ_Font(SQ_Fit(12));
    _timeLab.textColor = [UIColor getColor:@"888888"];
    _timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLab];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _typeLab.frame = CGRectMake(SQ_Fit(15), (self.height-_typeLab.height)/2, _typeLab.width, _typeLab.height);
    
    _numLab.frame = CGRectMake((self.width-_numLab.width)/2, (self.height-_numLab.height)/2, _numLab.width, _numLab.height);
    
    _timeLab.frame = CGRectMake(self.width-SQ_Fit(15)-_timeLab.width, (self.height-_timeLab.height)/2, _timeLab.width, _timeLab.height);

}

-(void)setModel:(SQRedStampsDetailsModel *)model{
    _model = model;
    
    _typeLab.text = model.type;
    [_typeLab sizeToFit];
    
    _numLab.text = model.number;
    [_numLab sizeToFit];
    
    _timeLab.text = model.time;
    [_timeLab sizeToFit];
    
}
@end
