//
//  SQHousingMemberController.m
//  ired6
//
//  Created by zhangchong on 2017/1/21.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQHousingMemberController.h"
#import "SQCertificationModel.h"
#import "SQHousingMemberCell.h"

@interface SQHousingMemberController ()

@end

@implementation SQHousingMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    
}

#pragma mark
#pragma mark - Tableview代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.model.detailStr.integerValue;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHousingMemberCell *cell = [[SQHousingMemberCell alloc]init];
    
    return cell;
}

-(void)setModel:(SQCertificationModel *)model{
    _model = model;
    
    self.title = model.itemStr;
    [self.tableView reloadData];
}

@end
