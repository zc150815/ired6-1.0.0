//
//  UILabel+ZCExtension.m
//
//  Created by Ning Xie on 16/8/28.
//  Copyright © 2016年 zhangchong. All rights reserved.
//

#import "UILabel+ZCExtension.h"

@implementation UILabel (ZCExtension)

+(instancetype)labelWithText:(NSString*)text textColor:(UIColor*)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.numberOfLines = 0;
    [label sizeToFit];
    label.textAlignment = textAlignment;
    
    return label;
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        
//        self.font
//    }
//    return self;
//}
@end
