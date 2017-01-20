//
//  SQPublicTools.m
//  ired6
//
//  Created by zhangchong on 2017/1/10.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQPublicTools.h"
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+YCLocation.h"


#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)


@interface SQPublicTools ()<CLLocationManagerDelegate>

@property (nonatomic,assign) BOOL isShowing;
@property (nonatomic, strong) CLLocationManager *manager;

@end
@implementation SQPublicTools

static SQPublicTools* _instanceType;
+(instancetype)sharedPublicTools
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[self alloc]init];
    });
    
    return _instanceType;
}
-(void)loginWithUserID:(NSString*)userID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userID forKey:@"UserIdentifier"];
    [defaults setBool:YES forKey:@"isLogin"];
    [defaults synchronize];
}

-(void)logoutWithUserId:(NSString*)userID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"UserIdentifier"];
    [defaults setBool:NO forKey:@"isLogin"];
    
    
    [defaults synchronize];
}

-(BOOL)isLogin{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"isLogin"];
}
#pragma mark  提示条
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    if (_isShowing) {
        return;
    }
    _isShowing = YES;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.alpha = 0;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = SQ_Font(SQ_Fit(15));
    label.x = SQ_BaseMargin;label.y = SQ_BaseMargin/2;
    [label sizeToFit];
    
    [showview addSubview:label];
    showview.center = CGPointMake(window.centerX, window.height*3/4);
    showview.bounds = CGRectMake(0, 0, label.width+SQ_BaseMargin*2, label.height+SQ_BaseMargin);

    [UIView animateWithDuration:time/2 animations:^{
        showview.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:time/2 animations:^{
            showview.alpha = 0;
        } completion:^(BOOL finished) {
            [showview removeFromSuperview];
            _isShowing = NO;
        }];
    }];
}
// 判断是否是11位手机号码
- (BOOL)judgePhoneNumber:(NSString *)phoneNum
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    // 一个判断是否是手机号码的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",CM_NUM,CU_NUM,CT_NUM];
    
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *mobile = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        NO;
    }
    
    // 无符号整型数据接收匹配的数据的数目
    NSUInteger numbersOfMatch = [regularExpression numberOfMatchesInString:mobile options:NSMatchingReportProgress range:NSMakeRange(0, mobile.length)];
    if (numbersOfMatch>0) return YES;
    
    return NO;
    
}
// 判断密码是否符合规则
- (BOOL)judgePassword:(NSString *)password{
    
    BOOL result = NO;
    NSInteger length = password.length;
    if (length >= 8 && length <= 16 ){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:password];
    }
    return result;
}

//开始定位
-(void)startLocation
{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
    {
        _manager=[[CLLocationManager alloc]init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestAlwaysAuthorization];
        _manager.distanceFilter = 100;
        [_manager startUpdatingLocation];
    }
    else
    {
        UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alvertView show];
    }
}
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CLLocation * location = [[CLLocation alloc]initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    CLLocation * marsLoction = [location locationMarsFromEarth];
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:marsLoction completionHandler:^(NSArray *placemarks,NSError *error){
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSString *fullAddress = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"][0];
            [defaults setObject:fullAddress forKey:FullAddress];
            [defaults setObject:placemark.name forKey:DetailAddress];
            [defaults setObject:placemark.locality forKey:CityName];

            NSNotificationCenter *notifi = [NSNotificationCenter defaultCenter];
            [notifi postNotificationName:@"LocationFinishedNotification" object:self];
        }
    }];
    [manager stopUpdatingLocation];

}
@end
