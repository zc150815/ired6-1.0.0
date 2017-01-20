//
//  SQTabBarController.m
//  SQ565
//
//  Created by zhangchong on 16/12/5.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import "SQTabBarController.h"
#import "SQNavigationController.h"
#import "SQHomePageViewController.h"
#import "SQLifeViewController.h"
#import "SQShoppingViewController.h"
#import "SQMineViewController.h"
#import "SQLoginViewController.h"


@interface SQTabBarController ()<UITabBarControllerDelegate>

@end

@implementation SQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self setupChildController];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self hiddenTopLineToBack];
}
-(void)hiddenTopLineToBack{
    
    for (UIView *lineView in self.tabBar.subviews)
    {
        if ([lineView isKindOfClass:[UIImageView class]] && lineView.bounds.size.height <= 1)
        {
            UIImageView *lineImage = (UIImageView *)lineView;
            [self.tabBar sendSubviewToBack:lineImage];
            
        }
    }
}

+(void)initialize{
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{
                                   NSFontAttributeName : [UIFont systemFontOfSize:12],
                                   NSForegroundColorAttributeName : SQ_RGBColor(67, 67, 67)
                                   } forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{
                                   NSFontAttributeName : [UIFont systemFontOfSize:12],
                                   NSForegroundColorAttributeName : [UIColor getColor:@"fb4142"]
                                   } forState:UIControlStateSelected];
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarTintColor:[UIColor whiteColor]];
}

-(void)setupChildController{
    
    [self addChildViewController:[[SQHomePageViewController alloc]init] title:@"首页" image:@"main_buttom_life_off" selectedImage:@"main_buttom_life_on"];
    [self addChildViewController:[[SQLifeViewController alloc]init] title:@"生活" image:@"main_buttom_rim_off" selectedImage:@"main_buttom_rim_on"];
    [self addChildViewController:[[SQShoppingViewController alloc]init] title:@"购物管理" image:@"main_buttom_discover_off" selectedImage:@"main_buttom_discover_on"];
    [self addChildViewController:[[SQMineViewController alloc]init] title:@"我的红六" image:@"main_buttom_me_off" selectedImage:@"main_buttom_me_on"];
}

-(void)addChildViewController:(UIViewController *)childController title:(NSString*)title image:(NSString*)imageName selectedImage:(NSString*)selectedImageName{
    
    childController.view.backgroundColor = SQ_RandomColor;
    [childController.tabBarItem setImage:[UIImage imageNamed:imageName]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImageName]];
    childController.tabBarItem.title = title;
    SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (![viewController.tabBarItem.title isEqualToString:@"首页"]) {
        
        if (![SQPublicTools sharedPublicTools].isLogin) {
            SQLoginViewController *login = [[SQLoginViewController alloc]init];
            [((UINavigationController *)tabBarController.selectedViewController)pushViewController:login animated:YES];
            return NO;
        }
    }
    
    return YES;
}
@end
