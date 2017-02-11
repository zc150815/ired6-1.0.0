//
//  SQGoodsListCell.m
//  ired6
//
//  Created by zhangchong on 2017/2/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQGoodsListCell.h"
#import "GridListModel.h"
#define BaseMargin 10

@interface  SQGoodsListCell ()

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *addShoppingCart;
@property (nonatomic, strong) UILabel *salesVolume;

@end

@implementation SQGoodsListCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _goodsImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_goodsImage];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont boldSystemFontOfSize:SQ_Fit(13)];
        _titleLabel.textColor = [UIColor getColor:@"343434"];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor getColor:@"fb4142"];
        _priceLabel.font = [UIFont systemFontOfSize:SQ_Fit(20)];
        [self.contentView addSubview:_priceLabel];
        
        _addShoppingCart = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addShoppingCart setBackgroundImage:[UIImage scaleFromImage:[UIImage imageNamed:@"shoppingCart01"] toSize:CGSizeMake(32, 32)] forState:UIControlStateNormal];
        _addShoppingCart.adjustsImageWhenHighlighted = NO;
        [self.contentView addSubview:_addShoppingCart];
        
        _salesVolume = [[UILabel alloc] init];
        _salesVolume.textColor = [UIColor getColor:@"888888"];
        _salesVolume.font = [UIFont systemFontOfSize:SQ_Fit(12)];
        [self.contentView addSubview:_salesVolume];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    if (self.isGrid) {
        
        CGFloat goodsImageWith = self.contentView.width-SQ_Fit(10);
        _goodsImage.frame = CGRectMake(SQ_Fit(5),SQ_Fit(5),goodsImageWith,goodsImageWith);
        
        _titleLabel.x = _goodsImage.x;
        _titleLabel.y = CGRectGetMaxY(_goodsImage.frame)+SQ_Fit(5);
        _titleLabel.width = _goodsImage.width;
        [_titleLabel sizeToFit];

        _addShoppingCart.bounds = CGRectMake(0, 0, SQ_Fit(30), SQ_Fit(30));
        _addShoppingCart.x = self.contentView.width - _addShoppingCart.width - SQ_Fit(5);
        _addShoppingCart.y = self.contentView.height - _addShoppingCart.height - SQ_Fit(5);
        [_addShoppingCart addTarget:self action:@selector(addShoppingCartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _priceLabel.x = _goodsImage.x;
        _priceLabel.y = self.height-SQ_Fit(25);
        _priceLabel.width = _addShoppingCart.x - _priceLabel.x;
        _priceLabel.height = SQ_Fit(20);

        _salesVolume.height = (_priceLabel.y - CGRectGetMaxY(_titleLabel.frame));
        _salesVolume.width = _priceLabel.width;
        _salesVolume.x = _goodsImage.x;
        _salesVolume.centerY = _salesVolume.height/2+CGRectGetMaxY(_titleLabel.frame);
        
    } else {
        CGFloat goodsImageHeight = self.contentView.height - SQ_Fit(10);
        _goodsImage.frame = CGRectMake(SQ_Fit(5),SQ_Fit(5),goodsImageHeight, goodsImageHeight);
        
        _titleLabel.x = CGRectGetMaxX(_goodsImage.frame)+SQ_Fit(5);
        _titleLabel.y = _goodsImage.y;
        _titleLabel.width = self.contentView.width - _titleLabel.x - SQ_Fit(5);
        [_titleLabel sizeToFit];

        _addShoppingCart.bounds = CGRectMake(0, 0, SQ_Fit(30), SQ_Fit(30));
        _addShoppingCart.x = self.contentView.width - _addShoppingCart.width - SQ_Fit(5);
        _addShoppingCart.y = self.contentView.height - _addShoppingCart.height - SQ_Fit(5);
        
        _priceLabel.x = _titleLabel.x;
        _priceLabel.y = self.height-SQ_Fit(25);
        _priceLabel.width = _addShoppingCart.x - _priceLabel.x;
        _priceLabel.height = SQ_Fit(20);
        
        _salesVolume.height = (_priceLabel.y - CGRectGetMaxY(_titleLabel.frame));
        _salesVolume.width = _priceLabel.width;
        _salesVolume.x = _titleLabel.x;
        _salesVolume.centerY = _salesVolume.height/2+CGRectGetMaxY(_titleLabel.frame);
    
    }
}
- (void)setModel:(GridListModel *)model
{
    _model = model;
    
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"shequ.png"]];

    _titleLabel.text = model.wname;
    
    //按钮文字格式
    NSMutableAttributedString *detailStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",model.jdPrice]];
    NSRange range = {0, 1};
    NSRange range1 = {1, detailStr.string.length-1};
    [detailStr addAttribute:NSFontAttributeName value:SQ_Font(SQ_Fit(14)) range:range];
    [detailStr addAttribute:NSFontAttributeName value:SQ_Font(SQ_Fit(21)) range:range1];
    _priceLabel.attributedText = detailStr;

    _salesVolume.text = @"月销量1000件";
}

-(void)addShoppingCartButtonClick:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(goodsListCell:addShoppingCartWithButton:)]) {
        [self.delegate goodsListCell:self addShoppingCartWithButton:sender];
    }
}
@end
