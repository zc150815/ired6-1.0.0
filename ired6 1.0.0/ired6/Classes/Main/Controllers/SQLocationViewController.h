//
//  SQLocationViewController.h
//  ired6
//
//  Created by zhangchong on 2017/1/13.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQLocationViewController;
@protocol SQLocationViewControllerDelegate <NSObject>

-(void)locationView:(SQLocationViewController*)locationView withLocationStr:(NSString*)locationStr;

@end

@interface SQLocationViewController : UIViewController

@property (nonatomic, weak) id<SQLocationViewControllerDelegate>delegate;

@end
