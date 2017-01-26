//
//  SQHousingMemberController.m
//  ired6
//
//  Created by zhangchong on 2017/1/21.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQHousingMemberController.h"
#import "SQCertificationModel.h"
#import "SQHouseCertificationModel.h"
#import "SQHousingMemberCell.h"

@interface SQHousingMemberController ()

@property (nonatomic, strong) UIButton *addMemberBtn;
@property (nonatomic, strong) NSArray *dataArr;


@end

@implementation SQHousingMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}
#pragma mark
#pragma mark 懒加载控件
-(UIButton *)addMemberBtn{
    if (!_addMemberBtn) {
        _addMemberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addMemberBtn setImage:[UIImage imageNamed:@"addItemGray"] forState:UIControlStateNormal];
        [_addMemberBtn setTitle:self.title forState:UIControlStateNormal];
        [_addMemberBtn setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
        [_addMemberBtn setBackgroundColor:[UIColor whiteColor]];
        _addMemberBtn.titleLabel.font = SQ_Font(SQ_Fit(16));
        self.addMemberBtn.bounds = CGRectMake(0, 0, SQ_Fit(345), SQ_Fit(48));
    }
    return _addMemberBtn;
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}

#pragma mark
#pragma mark Tableview代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == self.dataArr.count) {
        return 1;
    }
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.dataArr.count) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.addMemberBtn.center = cell.center;
        self.addMemberBtn.bounds = CGRectMake(0, 0, SQ_Fit(345), SQ_Fit(48));
        self.addMemberBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 12);

        if (self.canEdit) {
            [cell addSubview:self.addMemberBtn];
        }
        return cell;
    }
    SQHousingMemberCell *cell = [[SQHousingMemberCell alloc]init];
    SQCertificationModel *model = self.dataArr[indexPath.section][indexPath.row];
    if (!self.canEdit) {
        model.show = NO;
    }
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataArr.count>0) {
        return 0.01;
    }
    
    return SQ_Fit(20);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SQ_Fit(15);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SQ_Fit(48);
}


#pragma mark
#pragma mark 按钮点击方法





#pragma mark
#pragma mark Tableview代理方法
-(void)setModel:(SQHouseCertificationModel *)model{
    _model = model;
    self.title = model.item;
    self.dataArr = [SQCertificationModel mj_objectArrayWithKeyValuesArray:model.detailArr];

    [self.tableView reloadData];
}

@end
