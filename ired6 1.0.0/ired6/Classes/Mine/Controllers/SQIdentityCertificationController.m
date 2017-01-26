//
//  SQIdentityCertificationController.m
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQIdentityCertificationController.h"
#import "SQIdentityMemberController.h"
#import "SQIdentityCertificationCell.h"

#import "SQAttestListModel.h"
#import "SQCertificationModel.h"

@interface SQIdentityCertificationController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SQIdentityCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
    
}
-(void)setupUI{
    
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

-(void)loadData{
    
    [[SQNetworkingTools sharedNetWorkingTools] getNewIdentityClassDataWithCallBack:^(id response, NSError *error) {
        if (error) {
            [[SQPublicTools sharedPublicTools]showMessage:@"数据获取错误" duration:3];
            return ;
        }
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)response;
            self.dataArr = [SQAttestListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.tableView reloadData];
        }
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQIdentityCertificationCell *cell = [[SQIdentityCertificationCell alloc]init];
    SQAttestListModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SQ_Fit(48);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQIdentityMemberController *memberVC = [[SQIdentityMemberController alloc]init];
    memberVC.canEdit = YES;
    SQAttestListModel *identityModel = self.dataArr[indexPath.row];
    memberVC.title = identityModel.titleStr;
    memberVC.model = identityModel;
    [self.navigationController pushViewController:memberVC animated:YES];
}
@end
