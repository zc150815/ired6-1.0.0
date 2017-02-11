//
//  SQThirdCategoryCell.m
//  ired6
//
//  Created by zhangchong on 2017/2/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQThirdCategoryCell.h"
#import "SQGoodsClassificationModel.h"

@interface SQThirdCategoryCell ()

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsLabel;

@end

@implementation SQThirdCategoryCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _goodsImage = [[UIImageView alloc]init];
        _goodsImage.backgroundColor = [UIColor blueColor];
        _goodsImage.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_goodsImage];
        
        _goodsLabel = [[UILabel alloc]init];
        _goodsLabel.font = SQ_Font(SQ_Fit(12));
        _goodsLabel.textColor = [UIColor getColor:@"888888"];
        _goodsLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_goodsLabel];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat goodsImageWidth = self.contentView.width-2*SQ_Fit(5);
    _goodsImage.frame = CGRectMake(SQ_Fit(5), SQ_Fit(5), goodsImageWidth, goodsImageWidth);
    
    _goodsLabel.frame = CGRectMake(0, CGRectGetMaxY(_goodsImage.frame), self.contentView.width, self.contentView.height-CGRectGetMaxY(_goodsImage.frame));
    
}
-(void)setModel:(SQGoodsClassificationModel *)model{
    _model = model;
    
    _goodsLabel.text = @"三级分类";
    _goodsImage.image = [UIImage scaleFromImage:[UIImage imageNamed:@"iphoneSE(1)"] toSize:CGSizeMake(50, 50)];
}

@end
