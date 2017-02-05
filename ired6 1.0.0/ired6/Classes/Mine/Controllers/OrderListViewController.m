//
//  OrderListViewController.m
//  订单处理界面
//
//  Created by zhangchong on 2016/12/26.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewController.h"

@interface OrderListViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *orderListTypeChooseView;
@property (nonatomic, strong) UIView *indicatorView;
@property (strong, nonatomic) UIButton *currentSelectedBtn;
@property (nonatomic, strong) NSArray *btnTitleArray;
@property (strong, nonatomic) NSMutableArray<UIButton*> *btnArray;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation OrderListViewController

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
    
    for (NSInteger i = 0; i < self.btnTitleArray.count; i++) {
        OrderListTableViewController *vc = [[OrderListTableViewController alloc]init];
        [self addChildViewController:vc];
    }
    
    UIView *orderListTypeChooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, 30)];
    _orderListTypeChooseView.backgroundColor = [UIColor whiteColor];
    self.orderListTypeChooseView = orderListTypeChooseView;
    [self.view addSubview:self.orderListTypeChooseView];
    
    //订单类型按钮
    CGFloat height = _orderListTypeChooseView.frame.size.height;
    CGFloat width = _orderListTypeChooseView.frame.size.width/_btnTitleArray.count;
    for (NSInteger i = 0; i < _btnTitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_btnTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
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
    [_orderListTypeChooseView addSubview:indicatorView];
    indicatorView.frame = CGRectMake(0, height-2, width, 2);
    
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

    OrderListTableViewController *VC = self.childViewControllers[index];
    VC.view.frame = CGRectMake(scrollView.contentOffset.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    VC.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.orderListTypeChooseView.frame), 0, self.tabBarController.tabBar.frame.size.height, 0);
    VC.tableView.scrollIndicatorInsets = VC.tableView.contentInset;
    
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
