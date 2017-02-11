//
//  SQMineViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQMineViewController.h"
#import "SQAttestViewController.h"
#import "SQRedStampsController.h"
#import "SQMyOrderView.h"
#import "SQOrderController.h"

@interface SQMineViewController ()<UITableViewDelegate,UITableViewDataSource,SQMyOrderViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@[@"订单管理"],@[@"退出登录",@"认证管理",@"积分管理"]];
    [self setupUI];
}

-(void)setupUI{
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    UITableView *mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_ScreenHeight) style:UITableViewStyleGrouped];
    mineTableView.delegate = self;
    mineTableView.dataSource = self;
    mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellcell"];
    [self.view addSubview:mineTableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_Fit(100))];
    headerView.backgroundColor = [UIColor redColor];
    mineTableView.tableHeaderView = headerView;
}

#pragma mark
#pragma mark UITableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellcell" forIndexPath:indexPath];
    cell.textLabel.font = SQ_Font(SQ_Fit(15));
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"查看全部";
        label.textColor = [UIColor grayColor];
        label.font = SQ_Font(SQ_Fit(15));
        label.textAlignment = NSTextAlignmentRight;
        [label sizeToFit];
        cell.accessoryView = label;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        [[SQPublicTools sharedPublicTools]showMessage:@"查看全部" duration:3];
        UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        allBtn.tag = 1000;
        [self myOrderView:nil myOrderButtonActiton:allBtn];
    }
    
    if (indexPath.section == 1) {
        [self buttonClick:indexPath];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        SQMyOrderView *myOrderView = [[SQMyOrderView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_Fit(50))];
        myOrderView.delegate = self;
        return myOrderView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return SQ_Fit(60);
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SQ_Fit(48);
}
#pragma mark
#pragma mark SQMyOrderViewDelegate代理方法
-(void)myOrderView:(SQMyOrderView *)myOrderView myOrderButtonActiton:(UIButton *)sender{
    
    SQOrderController *orderList = [[SQOrderController alloc]init];
    switch (sender.tag) {
        case 1000:
            orderList.orderListType = 1000;
            break;
        case 1001:
            orderList.orderListType = 1001;
            break;
        case 1002:
            orderList.orderListType = 1002;
            break;
        case 1003:
            orderList.orderListType = 1003;
            break;
        case 1004:
            orderList.orderListType = 1004;
            break;
        case 1005:
            orderList.orderListType = 1005;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:orderList animated:YES];
}

-(void)buttonClick:(NSIndexPath*)indexPath{
    
    //退出登录
    if (indexPath.row == 0) {
        [[SQPublicTools sharedPublicTools] logoutWithUserId:@"zhangchong"];
        [self.tabBarController setSelectedIndex:0];
        [[SQPublicTools sharedPublicTools] showMessage:@"登出成功" duration:3];
        return;
    }
    //认证管理
    if (indexPath.row == 1) {
        SQAttestViewController *attestVC = [[SQAttestViewController alloc]init];
        [self.navigationController pushViewController:attestVC animated:YES];
        return;
    }
    
    //积分管理
    if (indexPath.row == 2) {
        SQRedStampsController *myPointVC = [[SQRedStampsController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:myPointVC animated:YES];
        return;
    }
}

@end
