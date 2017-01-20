//
//  SQHousingCertificationController.m
//  ired6
//
//  Created by zhangchong on 2017/1/19.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQHousingCertificationController.h"
#import "SQCertificationCell.h"
#import "SQLocationViewController.h"
#import "SQAttestListModel.h"
#import "SQCertificationModel.h"

@interface SQHousingCertificationController ()<UITableViewDelegate,UITableViewDataSource,SQLocationViewControllerDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SQHousingCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
}
-(void)loadData{
    
    NSArray *array = @[
                       @[
                           @{@"itemStr":@"所在小区",@"detailStr":@"华澳中心"},
                           @{@"itemStr":@"所在楼栋",@"detailStr":@"10号楼"},
                           @{@"itemStr":@"所在单元",@"detailStr":@"3单元"},
                           @{@"itemStr":@"所在楼层",@"detailStr":@"26楼"},
                           @{@"itemStr":@"所在房间",@"detailStr":@"26E"},
                           @{@"itemStr":@"我的身份",@"detailStr":@"房主"},
                           @{@"itemStr":@"其他信息",@"detailStr":@"面积:100m² 物业费:2.5元m²"}],
                       @[
                           @{@"itemStr":@"家有老人",@"detailStr":@"1"},
                           @{@"itemStr":@"家有小孩",@"detailStr":@"2"},
                           @{@"itemStr":@"残障人士",@"detailStr":@"3"},
                           @{@"itemStr":@"家有宠物",@"detailStr":@"4"}]
                       ];
    
    self.dataArray = [SQCertificationModel mj_objectArrayWithKeyValuesArray:array];
}
-(void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainTableView.frame = CGRectMake(0, 0, SQ_ScreenWidth, SQ_ScreenHeight-64);
    [self.view addSubview:_mainTableView];
    
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
#pragma mark 懒加载页面
-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.bounces = NO;
    }
    return _mainTableView;
}

#pragma mark
#pragma mark UITableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (section) {
        return self.canEdit?[self.dataArray[section] count]:[self.dataArray[section] count];
    }
    return self.canEdit?[self.dataArray[section] count]-1:[self.dataArray[section] count];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQCertificationCell *cell = [[SQCertificationCell alloc]init];
    
    SQCertificationModel *model = self.dataArray[indexPath.section][indexPath.row];
    
    if (self.canEdit) {
        model.canPush = YES;
        model.canSelected = indexPath.section;
        model.show = NO;
    }else{
        model.canPush = indexPath.section;
        model.canSelected = NO;
        model.show = YES;
    }
    cell.tag = [NSString stringWithFormat:@"10%zd%zd",indexPath.section,indexPath.row].integerValue;
    cell.model = model;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_Fit(30))];
    label.text = @"以下为居委会关照项(选填)";
    label.font = SQ_Font(SQ_Fit(15));
    label.textColor = [UIColor getColor:@"888888"];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?SQ_Fit(30):0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SQ_Fit(50);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        SQLocationViewController *locationVC = [[SQLocationViewController alloc]init];
        locationVC.delegate = self;
        [self.navigationController pushViewController:locationVC animated:YES];
    }
}
#pragma mark 分割线对齐方法
-(void)viewDidLayoutSubviews{
    
    if ([_mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_mainTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_mainTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark
#pragma mark SQLocationViewControllerDelegate代理方法
-(void)locationView:(SQLocationViewController *)locationView withLocationStr:(NSString *)locationStr{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    SQCertificationCell *cell = [_mainTableView cellForRowAtIndexPath:indexPath];
    for (UIView*view in cell.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *detailLab = (UILabel*)view;
            if (![detailLab.text isEqualToString:@"所在小区"]) {
                detailLab.text = locationStr;
            }
        }
    }
}




@end
