//
//  SQHomePageViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQHomePageViewController.h"
#import "SQGoodsClassificationController.h"

@interface SQHomePageViewController ()

@property (nonatomic, strong) NSArray *testArray;

@end

@implementation SQHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testArray = @[@"商品分类"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.testArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.testArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SQGoodsClassificationController *GoodsClassificationVC = [[SQGoodsClassificationController alloc]init];
        GoodsClassificationVC.title = self.testArray[indexPath.row];
        [self.navigationController pushViewController:GoodsClassificationVC animated:YES];
    }
}


@end
