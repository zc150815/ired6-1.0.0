//
//  SQShoppingCartShopCell.m
//  ired6
//
//  Created by zhangchong on 2017/2/4.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQShoppingCartShopCell.h"
#import "SQShoppingCartModel.h"

@interface SQShoppingCartShopCell ()

@property (nonatomic, strong) UIButton *shopIcon;

@end
@implementation SQShoppingCartShopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //选择商品btn
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"圆圈"] toSize:CGSizeMake(SQ_Fit(15), SQ_Fit(15))] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"打钩"] toSize:CGSizeMake(SQ_Fit(15), SQ_Fit(15))] forState:UIControlStateSelected];
        _selectedBtn.adjustsImageWhenHighlighted = NO;
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
        
        //店铺小图标
        _shopIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopIcon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shopIcon.titleLabel.font = SQ_Font(SQ_Fit(13));
        [self.contentView addSubview:_shopIcon];
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _selectedBtn.bounds = CGRectMake(0, 0, SQ_Fit(30), self.contentView.height);
    _selectedBtn.center = CGPointMake(_selectedBtn.width/2, self.contentView.height/2);
    
    _shopIcon.center = CGPointMake(CGRectGetMaxX(_selectedBtn.frame)+_shopIcon.width/2, self.contentView.height/2);
    
    
}
//选择点击事件
- (void)selectedClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shoppingCartShopCell:withSelectedModel:)]) {
        [self.delegate shoppingCartShopCell:self withSelectedModel:self.model];
    }
}

-(void)setModel:(SQShoppingCartModel *)model{
    _model = model;
    _selectedBtn.selected = model.isSelect;
    [_shopIcon setTitle:model.store_name forState:UIControlStateNormal];
    [_shopIcon sizeToFit];
}
@end
