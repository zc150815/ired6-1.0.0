//
//  ZCKeyboard.h
//  charity
//
//  Created by zhangchong on 2016/12/29.
//  Copyright © 2016年 com.charity.huakala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCKeyboard : UIView

/**
 *   textField内容变化回调
 *   value:变化之后的值
 **/
@property (copy,nonatomic)void(^textFieldValueChanged)(NSString *value);
/**
 *   初始化类方法
 *   textField参数：传入的是叫出该键盘的UITextField对象
 **/
+ (instancetype)keyboardWithTextField:(UITextField *)textField;

@end
