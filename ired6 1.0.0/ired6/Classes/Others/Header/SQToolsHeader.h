//
//  SQToolsHeader.h
//  ired6
//
//  Created by zhangchong on 2017/2/10.
//  Copyright © 2017年 ired6. All rights reserved.
//

#ifndef SQToolsHeader_h
#define SQToolsHeader_h


#ifdef DEBUG
#define SQ_NSLog(...) NSLog(__VA_ARGS__)
#else
#define SQ_NSLog(...)
#endif

#import "UIView+ZCExtension.h"
#import "UIColor+ZCExtension.h"
#import "UIImage+ZCExtension.h"
#import "UIImageView+WebCache.h"
#import "SQPublicTools.h"

#endif /* SQToolsHeader_h */
