//
//  SQRedStampsController.m
//  ired6
//
//  Created by zhangchong on 2017/1/26.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQRedStampsController.h"

@interface SQRedStampsController ()

@end

@implementation SQRedStampsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的红票";
    self.tableView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
