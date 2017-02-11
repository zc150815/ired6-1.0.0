//
//  SQShoppingCartGoodsCell.m
//  ired6
//
//  Created by zhangchong on 2017/2/4.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQShoppingCartGoodsCell.h"
#import "SQShoppingCartModel.h"

@interface SQShoppingCartGoodsCell ()

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *nowPriceLabel;
@property (nonatomic, strong) UIButton *cutCount;
@property (nonatomic, strong) UITextField *countTextField;
@property (nonatomic, strong) UIButton *addCount;
@property (nonatomic, strong) UILabel *goodNameLabel;
@property (nonatomic, strong) UILabel *colorTypeLabel;



@end
@implementation SQShoppingCartGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, 1)];
        line.backgroundColor = [UIColor getColor:@"f2f2f2"];
        [self.contentView addSubview:line];
        
        //选择商品btn
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"圆圈"] toSize:CGSizeMake(SQ_Fit(15), SQ_Fit(15))] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"打钩"] toSize:CGSizeMake(SQ_Fit(15), SQ_Fit(15))] forState:UIControlStateSelected];
        _selectedBtn.adjustsImageWhenHighlighted = NO;
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
        
        //商品图片
        _goodsImage = [[UIImageView alloc]init];
        [self.contentView addSubview:_goodsImage];
        
        //现在价格
        _nowPriceLabel = [[UILabel alloc]init];
        _nowPriceLabel.font = SQ_Font(SQ_Fit(15));
        _nowPriceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_nowPriceLabel];
        
        //减少商品数量
        _cutCount = [UIButton buttonWithType:UIButtonTypeCustom];
        _cutCount.titleLabel.font = SQ_Font(SQ_Fit(15));
        _cutCount.layer.borderWidth = 0.5;
        _cutCount.layer.borderColor = SQ_RGBColor(110, 110, 10).CGColor;
        _cutCount.layer.cornerRadius = 2;
        [_cutCount setTitle:@"-" forState:UIControlStateNormal];
        [_cutCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cutCount addTarget:self action:@selector(cutCountClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_cutCount];
        
        //数量
        _countTextField = [[UITextField alloc]init];
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        _countTextField.borderStyle = UITextBorderStyleNone;
        _countTextField.textAlignment = NSTextAlignmentCenter;
        _countTextField.font = SQ_Font(SQ_Fit(15));
        [self.contentView addSubview:_countTextField];
        
        //加号
        _addCount = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCount.titleLabel.font = SQ_Font(SQ_Fit(15));
        _addCount.layer.borderWidth = 0.5;
        _addCount.layer.borderColor = SQ_RGBColor(110, 110, 110).CGColor;
        _addCount.layer.cornerRadius = 2;
        [_addCount setTitle:@"+" forState:UIControlStateNormal];
        [_addCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addCount addTarget:self action:@selector(addCountClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addCount];
        
        //商品名称
        _goodNameLabel = [[UILabel alloc]init];
        _goodNameLabel.font = SQ_Font(SQ_Fit(13));
        _goodNameLabel.numberOfLines = 2;
        _goodNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_goodNameLabel];
        
        //颜色分类
        _colorTypeLabel = [[UILabel alloc]init];
        _colorTypeLabel.font = SQ_Font(SQ_Fit(12));
        _colorTypeLabel.textColor = SQ_RGBColor(123, 123, 123);
        _colorTypeLabel.numberOfLines = 2;
        [self.contentView addSubview:_colorTypeLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _selectedBtn.bounds = CGRectMake(0, 0, SQ_Fit(30), self.contentView.height);
    _selectedBtn.center = CGPointMake(_selectedBtn.width/2, self.contentView.height/2);
    
    _goodsImage.x = CGRectGetMaxX(_selectedBtn.frame);
    _goodsImage.y = SQ_Fit(5);
    _goodsImage.height = self.contentView.height-2*SQ_Fit(5);
    _goodsImage.width = _goodsImage.height;
    
    _nowPriceLabel.x = CGRectGetMaxX(_goodsImage.frame)+SQ_Fit(10);
    _nowPriceLabel.y = CGRectGetMaxY(_goodsImage.frame)-_nowPriceLabel.height;
    
    _addCount.width = SQ_Fit(20);
    _addCount.height = _addCount.width;
    _addCount.x = self.contentView.width-_addCount.width-SQ_Fit(10);
    _addCount.y = CGRectGetMaxY(_goodsImage.frame)-_addCount.width;
    
    _countTextField.frame = CGRectMake(_addCount.x-_addCount.width*2, _addCount.y, _addCount.width*2, _addCount.height);
    _cutCount.frame = CGRectMake(_countTextField.x-_addCount.width, _addCount.y, _addCount.width, _addCount.height);
    
    _goodNameLabel.x = CGRectGetMaxX(_goodsImage.frame)+SQ_Fit(10);
    _goodNameLabel.y = _goodsImage.y;
    _goodNameLabel.width = self.contentView.width - _goodNameLabel.x - SQ_Fit(5);
    [_goodNameLabel sizeToFit];
    
    _colorTypeLabel.x = _goodNameLabel.x;
    _colorTypeLabel.y = CGRectGetMaxY(_goodNameLabel.frame);
    _colorTypeLabel.width = self.contentView.width - _colorTypeLabel.x - SQ_Fit(5);
    _colorTypeLabel.height = _nowPriceLabel.y - CGRectGetMaxY(_goodNameLabel.frame);
}

-(void)setModel:(SQShoppingCartModel *)model{
    _model = model;
    _selectedBtn.selected = model.isSelect;
    _goodsImage.image = [UIImage imageNamed:model.goods_image];
    _nowPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.goods_price];
    [_nowPriceLabel sizeToFit];
    _countTextField.text = [NSString stringWithFormat:@"%zd",model.goods_num];
    _goodNameLabel.text = model.goods_name;
    _colorTypeLabel.text = [NSString stringWithFormat:@"颜色分类:%@",model.goods_name];
}

#pragma mark
#pragma mark 按钮点击事件
- (void)selectedClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shoppingCartGoodsCell:withSelectedModel:)]) {
        [self.delegate shoppingCartGoodsCell:self withSelectedModel:self.model];
    }
}
//减少按钮点击事件
- (void)cutCountClick:(UIButton *)sender{

    NSInteger countNumber = _countTextField.text.intValue;
    if (countNumber != 1) {
        _countTextField.text = [NSString stringWithFormat:@"%zd",countNumber-1];
        self.model.goods_num = countNumber-1;
        //向服务器发送请求
        [self.delegate shoppingCartGoodsChanged:self withSelectedModel:self.model];
    }
}
//增加按钮点击事件
- (void)addCountClick:(UIButton *)sender{

    NSInteger countNumber = _countTextField.text.intValue;
    //换成最大库存
    if (countNumber < 99) {
        _countTextField.text = [NSString stringWithFormat:@"%zd",countNumber+1];
        self.model.goods_num = countNumber+1;
        
        //向服务器发送请求
        [self.delegate shoppingCartGoodsChanged:self withSelectedModel:self.model];
    }
}



@end
