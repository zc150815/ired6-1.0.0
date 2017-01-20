//
//  UIBarButtonItem+ZCExtension.m
//
//  Created by Ning Xie on 16/8/24.
//  Copyright © 2016年 zhangchong. All rights reserved.
//

#import "UIBarButtonItem+ZCExtension.h"

@implementation UIBarButtonItem (ZCExtension)

+(instancetype)itemWithImage:(NSString*)image selectedImage:(NSString*)selectedImage action:(SEL)action target:(id)target{
 
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentBackgroundImage.size;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return item;
}

@end
