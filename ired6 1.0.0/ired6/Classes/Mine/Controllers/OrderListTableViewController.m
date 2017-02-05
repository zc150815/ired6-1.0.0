//
//  OrderListTableViewController.m
//  订单处理界面
//
//  Created by zhangchong on 2016/12/27.
//  Copyright © 2016年 Online Community Of China. All rights reserved.
//

#import "OrderListTableViewController.h"
#import "OrderListTableViewCell.h"

@interface OrderListTableViewController ()

@end

@implementation OrderListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator =  NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    self.tableView.backgroundColor = SQ_GlobalRBG;
}

#pragma mark UITableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.type;
    cell.backgroundColor = SQ_RandomColor;
    return cell;
}

-(void)setType:(NSString *)type{
    _type = type;
    [self.tableView reloadData];
}
@end
