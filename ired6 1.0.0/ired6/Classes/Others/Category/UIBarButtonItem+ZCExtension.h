//
//  UIBarButtonItem+ZCExtension.h
//
//  Created by Ning Xie on 16/8/24.
//  Copyright © 2016年 zhangchong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZCExtension)

+(instancetype)itemWithImage:(NSString*)image selectedImage:(NSString*)selectedImage action:(SEL)action target:(id)target;

@end
