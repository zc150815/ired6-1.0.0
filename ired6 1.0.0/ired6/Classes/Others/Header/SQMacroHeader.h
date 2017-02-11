//
//  SQMacroHeader.h
//  ired6
//
//  Created by zhangchong on 2017/2/10.
//  Copyright © 2017年 ired6. All rights reserved.
//

#ifndef SQMacroHeader_h
#define SQMacroHeader_h


#define SQ_Iphone6Height 667.0
#define SQ_Iphone6Width 375.0
#define SQ_Fit(x) (SQ_ScreenWidth*((x)/SQ_Iphone6Width))
#define SQ_FitHeight(x) (SQ_ScreenHeight*((x)/SQ_Iphone6Height))
#define SQ_Font(f) [UIFont systemFontOfSize:f]
#define SQ_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define SQ_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define SQ_RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SQ_RandomColor SQ_RGBColor(arc4random() % 256, arc4random() % 256, arc4random() % 256)


#define SQ_BaseMargin 10
#define SQ_BaseRBG SQ_RGBColor(251, 65, 66)
#define SQ_GlobalRBG SQ_RGBColor(240, 240, 240)
#define SQ_DarkGrewColor SQ_RGBColor(85, 85, 85)
#define SQ_LightGrewColor SQ_RGBColor(136, 136, 136)
#define SQ_NavightionBarHeight 64



#define FullAddress @"FullAddress"
#define DetailAddress @"DetailAddress"
#define CommunityName @"CommunityName"
#define CityName @"CityName"

#endif /* SQMacroHeader_h */
