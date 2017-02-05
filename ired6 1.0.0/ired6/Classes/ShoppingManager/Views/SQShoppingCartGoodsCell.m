//
//  SQShoppingCartGoodsCell.m
//  ired6
//
//  Created by zhangchong on 2017/2/4.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQShoppingCartGoodsCell.h"
#import "SQShoppingCartModel.h"

@implementation SQShoppingCartGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        //选择商品btn
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"打钩"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _selectedBtn.bounds = CGRectMake(0, 0, SQ_Fit(15), SQ_Fit(15));
    _selectedBtn.center = CGPointMake(SQ_Fit(10)+_selectedBtn.width/2, self.contentView.height/2);
}
//选择点击事件
- (void)selectedClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shoppingCartGoodsCell:withSelectedModel:)]) {
        [self.delegate shoppingCartGoodsCell:self withSelectedModel:self.model];
    }
}
-(void)setModel:(SQShoppingCartModel *)model{
    _model = model;
    _selectedBtn.selected = model.isSelect;

}

@end
