//
//  bottomPriceView.m
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "BottomPriceView.h"

@interface BottomPriceView ()

/**结算btn*/
@property (nonatomic, strong) UIButton *payBtn;
/**合计label*/
@property (nonatomic, strong) UILabel *allPriceLabel;

@end
@implementation BottomPriceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //选择商品btn
        UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectedBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"圆圈"] toSize:CGSizeMake(SQ_Fit(15), SQ_Fit(15))] forState:UIControlStateNormal];
        [selectedBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"打钩"] toSize:CGSizeMake(SQ_Fit(15), SQ_Fit(15))] forState:UIControlStateSelected];
        selectedBtn.adjustsImageWhenHighlighted = NO;
        [selectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        selectedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        selectedBtn.titleLabel.font = SQ_Font(SQ_Fit(13));
        selectedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        selectedBtn.frame = CGRectMake(0, 0, frame.size.height*1.5, frame.size.height);
        selectedBtn.tag = 1000;
        [self addSubview:selectedBtn];
        [selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        self.selectedBtn = selectedBtn;
        
        //结算btn
        _payStr = @"结算(0)";
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.backgroundColor = [UIColor getColor:@"fb4142"];
        payBtn.titleLabel.font = SQ_Font(SQ_Fit(13));
        [payBtn setTitle:_payStr forState:UIControlStateNormal];
        payBtn.frame = CGRectMake(frame.size.width - SQ_Fit(90), 0, SQ_Fit(90), frame.size.height);
        payBtn.tag = 1001;
        [self addSubview:payBtn];
        [payBtn addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.payBtn = payBtn;
        
        
        //合计label
        _attAllStr = @"合计:￥0.00";
        UILabel *allPriceLabel = [[UILabel alloc]init];
        allPriceLabel.font = SQ_Font(SQ_Fit(14));
        allPriceLabel.minimumScaleFactor = SQ_Fit(11);
        allPriceLabel.textAlignment = NSTextAlignmentRight;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:_attAllStr];
        //合计label添加属性
        NSRange range = {_attAllStr.length-3, 3};
        NSRange range1 = {3, _attAllStr.length-3};
        [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:SQ_Fit(11)] range:range];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor getColor:@"fb4142"] range:range1];
        allPriceLabel.attributedText = attStr;
        allPriceLabel.frame = CGRectMake(CGRectGetMaxX(_selectedBtn.frame), 0, frame.size.width-CGRectGetMaxX(_selectedBtn.frame)-_payBtn.width-SQ_Fit(10), frame.size.height);
        [self addSubview:allPriceLabel];
        self.allPriceLabel = allPriceLabel;
    }
    return self;
}
#pragma mark 
#pragma mark 按钮点击事件
- (void)selectedClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(bottomPriceView:buttonClickWith:)]) {
        [self.delegate bottomPriceView:self buttonClickWith:sender];
    }
}
-(void)payButtonClick:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(bottomPriceView:buttonClickWith:)]) {
        [self.delegate bottomPriceView:self buttonClickWith:sender];
    }
}
#pragma mark
#pragma mark set方法实现
- (void)setIsSelectBtn:(BOOL)isSelectBtn{
   
    _selectedBtn.selected = !isSelectBtn;
    [self selectedClick:_selectedBtn];
}

- (void)setPayStr:(NSString *)payStr{
    [_payBtn setTitle:[NSString stringWithFormat:@"结算(%@)", payStr] forState:UIControlStateNormal];
}

- (void)setAttAllStr:(NSString *)attAllStr{
    _attAllStr = [NSString stringWithFormat:@"合计:￥%@", attAllStr];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:_attAllStr];
    //添加属性
    NSRange range = {_attAllStr.length - 3, 3};
    NSRange range1 = {3, _attAllStr.length - 3};
    [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:SQ_Fit(11)] range:range];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor getColor:@"fb4142"] range:range1];
    _allPriceLabel.attributedText = attStr;
}


@end
