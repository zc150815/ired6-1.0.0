//
//  SQOrderListCell.m
//  ired6
//
//  Created by zhangchong on 2017/2/8.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQOrderListCell.h"
#import "SQOrderTypeListModel.h"

@interface SQOrderListCell ()
@property (nonatomic, strong) UIView *margin;

@property (nonatomic, strong) UIButton *shopName;
@property (nonatomic, strong) UILabel *orderType;
@property (nonatomic, strong) UILabel *orderAcount;

@property (nonatomic, strong) UIButton *functionBtn;


@end
@implementation SQOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setupUI{
    
    _margin = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_Fit(10))];
    _margin.backgroundColor = [UIColor getColor:@"f2f2f2"];
    [self.contentView addSubview:_margin];
    
    _shopName = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shopName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _shopName.titleLabel.font = SQ_Font(SQ_Fit(15));
    _shopName.adjustsImageWhenHighlighted = NO;
    [self.contentView addSubview:_shopName];
    
    _orderType = [[UILabel alloc]init];
    _orderType.textColor = [UIColor redColor];
    _orderType.font = SQ_Font(SQ_Fit(15));
    [self.contentView addSubview:_orderType];
    
    _orderAcount = [[UILabel alloc]init];
    _orderAcount.font = SQ_Font(SQ_Fit(15));
    [self.contentView addSubview:_orderAcount];
    
    _functionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _functionBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
    _functionBtn.layer.borderWidth = 0.5;
    _functionBtn.layer.cornerRadius = SQ_Fit(5);
    [_functionBtn.layer masksToBounds];
    [self.contentView addSubview:_functionBtn];
    [_functionBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _shopName.x = SQ_Fit(10);
    _shopName.y = CGRectGetMaxY(_margin.frame);
    
    _orderType.x = self.contentView.width - _orderType.width-SQ_Fit(10);
    _orderType.centerY = _shopName.centerY;
    
    _orderAcount.x = SQ_Fit(10);
    _orderAcount.y = self.contentView.height - _orderAcount.height - SQ_Fit(10);
    
    _functionBtn.width = SQ_Fit(75);
    _functionBtn.height = SQ_Fit(25);
    _functionBtn.x = self.contentView.width - _functionBtn.width-SQ_Fit(10);
    _functionBtn.centerY = _orderAcount.centerY;
    
    
}
-(void)setModel:(SQOrderTypeListModel *)model{
    _model = model;
    
    [_shopName setTitle:model.ShopName forState:UIControlStateNormal];
    [_shopName sizeToFit];
    
    //订单状态
    NSString *type;
    NSString *functionStr;
    switch (model.OrderType.integerValue) {
        case 1000:
            type = @"交易成功";
            functionStr = @"追加评论";
            break;
        case 1001:
            type = @"待付款";
            functionStr = @"付款";
            break;
        case 1002:
            type = @"待发货";
            functionStr = @"提醒发货";
            break;
        case 1003:
            type = @"待收货";
            functionStr = @"确认收货";
            break;
        case 1004:
            type = @"待评价";
            functionStr = @"评价";
            break;
        default:
            break;
    }
    _orderType.text = type;
    [_orderType sizeToFit];
    [_functionBtn setTitle:functionStr forState:UIControlStateNormal];
    
    
    //功能按钮
    UIColor *functionStrColor;
    UIColor *functionBGColor;
    UIColor *functionBorderColor;
    if (model.OrderType.integerValue == 1000) {
        functionStrColor = [UIColor blackColor];
        functionBGColor = [UIColor whiteColor];
        functionBorderColor = [UIColor blackColor];
    }else{
        functionStrColor = [UIColor whiteColor];
        functionBGColor = [UIColor orangeColor];
        functionBorderColor = [UIColor orangeColor];
    }
    [_functionBtn setTitleColor:functionStrColor forState:UIControlStateNormal];
    [_functionBtn setBackgroundColor:functionBGColor];
    _functionBtn.layer.borderColor = functionBorderColor.CGColor;
    
    
    //合计
    NSMutableAttributedString *detailStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"合计: ¥%@",model.OrderAmount]];
    NSRange range = {0, 3};
    NSRange range1 = {3, detailStr.string.length-3};
    [detailStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    [detailStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
    _orderAcount.attributedText = detailStr;
    [_orderAcount sizeToFit];
    
    

}

-(void)functionButtonClick:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(orderListCell:withClickButton:)]) {
        [self.delegate orderListCell:self withClickButton:sender];
    }
}
@end
