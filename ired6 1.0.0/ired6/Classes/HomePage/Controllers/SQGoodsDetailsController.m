//
//  SQGoodsDetailsController.m
//  ired6
//
//  Created by zhangchong on 2017/2/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQGoodsDetailsController.h"
#import "UINavigationBar+Awesome.h"

@interface SQGoodsDetailsController ()<UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate>

@end

@implementation SQGoodsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.translucent = NO;

}
#pragma mark
#pragma mark 收藏按钮分享按钮创建方法
-(UIButton*)setupButtonWithImage:(UIImage*)image selector:(SEL)selector{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    button.layer.cornerRadius = button.width/2;
    button.layer.masksToBounds = YES;
    [button setBackgroundColor:[UIColor grayColor]];
    [button setImage:[UIImage scaleFromImage:image toSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    return button;
}
#pragma mark 页面搭建
-(void)setupUI{
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = YES;
    UIButton *likeBtn = [self setupButtonWithImage:[UIImage imageNamed:@"favorite_nav"] selector:@selector(likeButtonClick:)];
    UIButton *shareBtn = [self setupButtonWithImage:[UIImage imageNamed:@"share_nav"] selector:@selector(shareButtonClick:)];
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc]initWithCustomView:likeBtn],
                                                [[UIBarButtonItem alloc]initWithCustomView:shareBtn]
                                                ];
    UIButton *popBtn = [self setupButtonWithImage:[UIImage imageNamed:@"return"] selector:@selector(popButtonClick:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:popBtn];
    
    //操作视图
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, SQ_ScreenHeight-SQ_Fit(50), SQ_ScreenWidth, SQ_Fit(50))];
    testView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testView];
    
    //商品详情页
    UITableView *goodsDetailView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, testView.y) style:UITableViewStyleGrouped];
    goodsDetailView.delegate = self;
    goodsDetailView.dataSource = self;
    goodsDetailView.bounces = NO;
    [self.view addSubview:goodsDetailView];
}
#pragma mark
#pragma mark UITableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.backgroundColor = [UIColor blueColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.backgroundColor = [UIColor blueColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SQ_Fit(300);
    }
    return 50;
}
#pragma mark
#pragma mark 按钮点击事件
-(void)likeButtonClick:(UIButton *)sender{
    [[SQPublicTools sharedPublicTools]showMessage:@"收藏成功" duration:3];
}
-(void)shareButtonClick:(UIButton *)sender{
    [[SQPublicTools sharedPublicTools]showMessage:@"分享成功" duration:3];

}
-(void)popButtonClick:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
