//
//  UITextField+ZCExtension.m
//
//  Created by Ning Xie on 16/8/27.
//  Copyright © 2016年 zhangchong. All rights reserved.
//

#import "UITextField+ZCExtension.h"

@implementation UITextField (ZCExtension)


+(instancetype)textfieldWithPlaceholder:(NSString*)placeholder backgroundImage:(NSString*)backgroundImage fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor delegate:(id)delegate{
    
    UITextField *textField = [[UITextField alloc]init];
    
    textField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundImage]];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.textColor = textColor;
    
    textField.delegate = delegate;
    
    return textField;
    
}
@end
