//
//  SQTextField.m
//  ired6
//
//  Created by zhangchong on 2017/1/10.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQTextField.h"

@interface SQTextField ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *leftviewLab;
@property (nonatomic, strong) UIButton *rightviewBtn;


@end
@implementation SQTextField

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textAlignment = NSTextAlignmentLeft;
        self.font = SQ_Font(SQ_Fit(16));
        self.textColor = [UIColor getColor:@"343434"];
        
        
        _leftviewLab = [[UILabel alloc]init];
        _leftviewLab.font = SQ_Font(SQ_Fit(16));
        _leftviewLab.textColor = [UIColor getColor:@"343434"];
        self.leftView = _leftviewLab;
        
        _rightviewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightviewBtn setBackgroundImage:[UIImage imageNamed:@"password-notsee"] forState:UIControlStateNormal];
        [_rightviewBtn setBackgroundImage:[UIImage imageNamed:@"password-see"] forState:UIControlStateSelected];
        _rightviewBtn.bounds = CGRectMake(0, 0, SQ_Fit(18), SQ_Fit(18));
        self.rightView = _rightviewBtn;
        [_rightviewBtn addTarget:self action:@selector(passwordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor getColor:@"343434"];
        [self addSubview:_lineView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.leftViewStr) {
        _leftviewLab.text = self.leftViewStr;
        self.leftView.bounds = CGRectMake(0, 0, SQ_Fit(50)+SQ_Fit(10), self.height);
    }
//    if (self.isPassword) {
//        self.rightView.bounds = CGRectMake(0, 0, SQ_Fit(18), SQ_Fit(18));
//    }
    _lineView.frame = CGRectMake(self.leftView.width-SQ_Fit(5), self.height-0.5, self.width-self.leftView.width+SQ_Fit(5), 0.5);
    
    self.leftViewMode = self.leftViewStr.length?UITextFieldViewModeAlways:UITextFieldViewModeNever;
    self.rightViewMode = self.isPassword?UITextFieldViewModeAlways:UITextFieldViewModeNever;
}
-(void)passwordButtonClick:(UIButton*)sender{
    if (self.isPassword) {
        self.secureTextEntry = sender.selected;
    }
    sender.selected = !sender.selected;
}
@end
