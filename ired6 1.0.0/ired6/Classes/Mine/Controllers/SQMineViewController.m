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


@interface SQMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *testDataArr;

@end

@implementation SQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testDataArr = @[@"退出登录",@"认证管理",@"积分管理"];
    [self test];
}


//测试用按钮
-(void)test{
    
    UITableView *testTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_ScreenHeight-70)];
    
    testTableView.delegate = self;
    testTableView.dataSource = self;
    [testTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellcell"];
    [self.view addSubview:testTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.testDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellcell" forIndexPath:indexPath];
    cell.textLabel.text = self.testDataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self buttonClick:indexPath];
}

//测试用按钮点击方法
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
        SQRedStampsController *myPointVC = [[SQRedStampsController alloc]init];
        [self.navigationController pushViewController:myPointVC animated:YES];
        return;
    }
}

@end
