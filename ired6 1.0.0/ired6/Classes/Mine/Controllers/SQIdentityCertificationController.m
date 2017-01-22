//
//  SQIdentityCertificationController.m
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQIdentityCertificationController.h"
#import "SQCertificationModel.h"
#import "SQIdentityCertificationCell.h"

@interface SQIdentityCertificationController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SQIdentityCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[
                        @{@"state":@"1",@"itemImage":@"realName",@"itemStr":@"实名认证"},
                        @{@"state":@"1",@"itemImage":@"merchantStaff",@"itemStr":@"商户服务人员"},
                        @{@"state":@"0",@"itemImage":@"communityStaff",@"itemStr":@"社区工作人员"},
                        @{@"state":@"0",@"itemImage":@"Housekeeper",@"itemStr":@"社区管理认证"}
                       ];
    self.dataArr = [SQCertificationModel mj_objectArrayWithKeyValuesArray:array];
    
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQIdentityCertificationCell *cell = [[SQIdentityCertificationCell alloc]init];
    
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SQ_Fit(48);
}
@end
