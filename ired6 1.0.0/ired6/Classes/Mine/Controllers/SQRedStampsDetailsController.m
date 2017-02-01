//
//  SQRedStampsDetailsController.m
//  ired6
//
//  Created by zhangchong on 2017/1/30.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQRedStampsDetailsController.h"
#import "SQRedStampsModel.h"
#import "SQRedStampsDetailsModel.h"
#import "SQRedStampsDetailCell.h"

@interface SQRedStampsDetailsController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SQRedStampsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
-(void)setupUI{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}

#pragma mark Tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQRedStampsDetailCell *cell = [[SQRedStampsDetailCell alloc]init];
    SQRedStampsDetailsModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SQ_Fit(48);
}

-(void)setModel:(SQRedStampsModel *)model{
    _model = model;
    
    self.title = model.itemStr;
    self.dataArr = [SQRedStampsDetailsModel mj_objectArrayWithKeyValuesArray:model.detail];
    [self.tableView reloadData];
}

@end
