//
//  SQOrderController.m
//  ired6
//
//  Created by zhangchong on 2017/2/8.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQOrderController.h"
#import "SQOrderListController.h"

@interface SQOrderController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *orderListTypeChooseView;//订单类型选项条
@property (nonatomic, strong) NSArray *btnTitleArray;//订单类型选项按钮
@property (nonatomic, strong) UIView *indicatorView;//

@property (strong, nonatomic) UIButton *currentSelectedBtn;//当前选中的订单类型
@property (strong, nonatomic) NSMutableArray<UIButton*> *btnArray;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SQOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnTitleArray = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"];
    [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIButton *button = self.btnArray[self.orderListType-1000];
    [self postTypeButtonAction:button];
}
#pragma mark
#pragma mark 懒加载数据
-(NSMutableArray<UIButton *> *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
-(void)setupUI{
    
    self.extendedLayoutIncludesOpaqueBars = YES;

    for (NSInteger i = 0; i < self.btnTitleArray.count; i++) {
        SQOrderListController *vc = [[SQOrderListController alloc]init];
        [self addChildViewController:vc];
    }
    
    UIView *orderListTypeChooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SQ_ScreenWidth, SQ_Fit(30))];
    orderListTypeChooseView.backgroundColor = [UIColor whiteColor];
    orderListTypeChooseView.layer.borderWidth = 0.5;
    orderListTypeChooseView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:orderListTypeChooseView];
    self.orderListTypeChooseView = orderListTypeChooseView;
    
    //订单类型按钮
    CGFloat height = _orderListTypeChooseView.frame.size.height;
    CGFloat width = _orderListTypeChooseView.frame.size.width/_btnTitleArray.count;
    for (NSInteger i = 0; i < _btnTitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_btnTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = SQ_Font(SQ_Fit(12));
        button.frame = CGRectMake(i*width, 0, width, height);
        button.backgroundColor = [UIColor whiteColor];
        button.tag = 1000 + i;
        [self.btnArray addObject:button];
        [_orderListTypeChooseView addSubview:button];
        [button addTarget:self action:@selector(postTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //滚动小条
    UIView *indicatorView =[[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.frame = CGRectMake(0, height-SQ_Fit(2), width, SQ_Fit(2));
    [_orderListTypeChooseView addSubview:indicatorView];
    
    //滚动视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*_btnArray.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = SQ_GlobalRBG;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    [self.view insertSubview:scrollView atIndex:0];
    
    [self scrollViewDidEndDecelerating:scrollView];
}
#pragma mark
#pragma mark 导航栏视图按钮点击事件
-(void)postTypeButtonAction:(UIButton*)sender{
    //滚动视图滚动
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width*(sender.tag-1000), 0) animated:NO];
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
    
}

#pragma mark
#pragma mark UIScrollView代理方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    
    SQOrderListController *VC = self.childViewControllers[index];
    VC.tableView.frame = CGRectMake(scrollView.contentOffset.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    [VC.tableView setContentInset:UIEdgeInsetsMake(64+SQ_Fit(30), 0, 0, 0)];
    [scrollView addSubview:VC.tableView];
    
    switch (self.btnArray[index].tag) {
        case 1000:
            VC.type = @"全部";
            break;
        case 1001:
            VC.type = @"待付款";
            break;
        case 1002:
            VC.type = @"待发货";
            break;
        case 1003:
            VC.type = @"待收货";
            break;
        case 1004:
            VC.type = @"待评价";
            break;
        case 1005:
            VC.type = @"退款/售后";
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0 animations:^{
        self.indicatorView.frame = CGRectMake(self.btnArray[index].frame.origin.x, self.orderListTypeChooseView.frame.size.height-2, self.btnArray[index].frame.size.width, 2);
    }];
    
    self.currentSelectedBtn.enabled = YES;
    self.btnArray[index].enabled = NO;
    self.currentSelectedBtn = self.btnArray[index];
    self.title = self.btnTitleArray[index];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}


@end
