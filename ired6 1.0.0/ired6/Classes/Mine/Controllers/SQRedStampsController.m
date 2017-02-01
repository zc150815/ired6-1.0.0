//
//  SQRedStampsController.m
//  ired6
//
//  Created by zhangchong on 2017/1/26.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQRedStampsController.h"
#import "SQRedStampsHeaderView.h"
#import "SQRedStampsModel.h"
#import "SQRedStampsCell.h"
#import "SQRedStampsDetailsController.h"

@interface SQRedStampsController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UICollectionView *guessView;


@end

@implementation SQRedStampsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}
#pragma mark
#pragma mark 懒加载数据

-(UICollectionView *)guessView{
    if (!_guessView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(SQ_ScreenWidth/2, SQ_Fit(150));
        _guessView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_Fit(300)) collectionViewLayout:flowLayout];
        _guessView.delegate = self;
        _guessView.dataSource = self;
        _guessView.showsVerticalScrollIndicator = NO;
        _guessView.showsHorizontalScrollIndicator = NO;
        [_guessView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"guessViewID"];
    }
    return _guessView;
}

#pragma mark
#pragma mark 页面布局加载数据
-(void)setupUI{
    
    self.title = @"我的红票";
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    
    SQRedStampsHeaderView *headerView = [[SQRedStampsHeaderView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_Fit(150))];
    headerView.backgroundColor = [UIColor getColor:@"fb4142"];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = self.guessView;
    
    [[SQNetworkingTools sharedNetWorkingTools]getRedStampsDataWithCallBack:^(id response, NSError *error) {
        if (error) {
            [[SQPublicTools sharedPublicTools]showMessage:@"数据获取错误" duration:3];
            return;
        }
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)response;
            self.dataArr = [SQRedStampsModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark
#pragma mark UITableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQRedStampsCell *cell = [[SQRedStampsCell alloc]init];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SQ_Fit(48);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQRedStampsDetailsController *detailsVC = [[SQRedStampsDetailsController alloc]init];
    
    SQRedStampsModel *model = self.dataArr[indexPath.row];
    detailsVC.model = model;
    
    [self.navigationController pushViewController:detailsVC animated:YES];
}

#pragma mark
#pragma mark UICollectionView代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"guessViewID" forIndexPath:indexPath];
    cell.backgroundColor = SQ_RandomColor;
    return cell;
}
@end
