//
//  SQIdentityMemberController.m
//  ired6
//
//  Created by zhangchong on 2017/1/24.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQIdentityMemberController.h"
#import "SQIdentityMemberCell.h"
#import "SQCertificationModel.h"
#import "SQAttestListModel.h"

@interface SQIdentityMemberController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SQIdentityMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
-(void)setupUI{
    
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor getColor:@"fb4142"] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor whiteColor]];
    saveBtn.titleLabel.font = SQ_Font(13);
    saveBtn.bounds = CGRectMake(0, 0, 50, 30);
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.canEdit?saveBtn:nil];
}
#pragma mark
#pragma mark 按钮点击方法

-(void)saveButtonClick:(UIButton*)sender{
    
    [[SQPublicTools sharedPublicTools]showMessage:@"上传成功" duration:3];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark
#pragma mark 懒加载数据

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}
#pragma mark
#pragma mark Tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQIdentityMemberCell *cell = [[SQIdentityMemberCell alloc]init];
    SQCertificationModel *model = self.dataArr[indexPath.row];
    if (self.canEdit) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        model.show = NO;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        model.show = YES;
    }
    cell.model = model;
    return cell;
}

-(void)setModel:(SQAttestListModel *)model{
    _model = model;
    
    NSArray *array = (NSArray*)model.detail;
    self.dataArr = [SQCertificationModel mj_objectArrayWithKeyValuesArray:array];
    [self.tableView reloadData];
}

@end
