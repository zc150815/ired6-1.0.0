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

@end

@implementation SQHousingMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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


#pragma mark
#pragma mark Tableview代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.model.detailArr.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == self.model.detailArr.count) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.model.detailArr.count) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        self.addMemberBtn.center = cell.center;
        [cell addSubview:self.addMemberBtn];
        return cell;
    }
    SQHousingMemberCell *cell = [[SQHousingMemberCell alloc]init];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.model.detailArr.count>0) {
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
    
    SQ_NSLog(@"%zd",model.detailArr.count);

    [self.tableView reloadData];
}

@end
