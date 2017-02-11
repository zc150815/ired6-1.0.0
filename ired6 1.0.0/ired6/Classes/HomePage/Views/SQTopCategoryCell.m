//
//  SQTopCategoryCell.m
//  ired6
//
//  Created by zhangchong on 2017/2/7.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQTopCategoryCell.h"
#import "SQGoodsClassificationModel.h"

@interface SQTopCategoryCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UIView *line;


@end
@implementation SQTopCategoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = SQ_Font(SQ_Fit(13));
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        
        _selectedView = [[UIView alloc]init];
        _selectedView.backgroundColor = [UIColor redColor];
        _selectedView.hidden = YES;
        [self.contentView addSubview:_selectedView];
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor getColor:@"cccccc"];
        [self.contentView addSubview:_line];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLab.frame = self.contentView.frame;
    _selectedView.frame = CGRectMake(0, 0, SQ_Fit(3), self.contentView.height);
    _line.frame = CGRectMake(0, self.contentView.height-0.5, self.contentView.width, 0.5);
}
-(void)setModel:(SQGoodsClassificationModel *)model{
    _model = model;
    
    _titleLab.text = model.FirstName;
    _selectedView.hidden = !model.isSelected;
    
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:NO];
    _titleLab.backgroundColor = !_selectedView.hidden?[UIColor getColor:@"f2f2f2"]:[UIColor whiteColor];
    _titleLab.textColor = _selectedView.hidden?[UIColor getColor:@"343434"]:[UIColor getColor:@"fb4142"];
    
    self.userInteractionEnabled = _selectedView.hidden;
}
@end
