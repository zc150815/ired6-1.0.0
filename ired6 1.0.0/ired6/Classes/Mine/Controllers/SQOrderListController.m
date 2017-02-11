//
//  SQOrderListController.m
//  ired6
//
//  Created by zhangchong on 2017/2/8.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQOrderListController.h"
#import "SQOrderTypeListModel.h"
#import "SQOrderListCell.h"

@interface SQOrderListController ()<SQOrderListCellDelegate>

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SQOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}
-(void)setupUI{
    
    self.tableView.bounces = NO;
    self.tableView.rowHeight = SQ_Fit(200);
    self.tableView.showsVerticalScrollIndicator =  NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SQOrderListCell class] forCellReuseIdentifier:@"OrderListCellID"];
}
-(void)loadData{
    
    [[SQNetworkingTools sharedNetWorkingTools]getOrderTypeListDataWithOrderType:nil CallBack:^(id response, NSError *error) {
        
        if (error) {
            [[SQPublicTools sharedPublicTools]showMessage:@"数据获取错误" duration:3];
            return;
        }
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)response;
            
            self.dataArr = [SQOrderTypeListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.tableView reloadData];
        }
    }];
    
}
#pragma mark UITableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCellID" forIndexPath:indexPath];
    SQOrderTypeListModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}
#pragma mark SQOrderListCell代理方法
-(void)orderListCell:(SQOrderListCell *)cell withClickButton:(UIButton *)sender{
    
    NSString *str = sender.titleLabel.text;
    
    [[SQPublicTools sharedPublicTools]showMessage:str duration:3
     ];
}


-(void)setType:(NSString *)type{
    _type = type;
    
    [self loadData];
    [self.tableView reloadData];
}
@end
