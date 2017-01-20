//
//  SQWebViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/18.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQWebViewController.h"

@interface SQWebViewController ()

@property (nonatomic, strong) UIWebView *advertisementView;

@end

@implementation SQWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.URLString]];
    [self.advertisementView loadRequest:request];
}

-(UIWebView *)advertisementView{
    if (!_advertisementView) {
        _advertisementView = [[UIWebView alloc]init];
        
    }
    return _advertisementView;
}
@end
