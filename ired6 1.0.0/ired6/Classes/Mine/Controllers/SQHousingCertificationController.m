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

@interface SQHousingCertificationController ()<UITableViewDelegate,UITableViewDataSource,SQLocationViewControllerDelegate>
@property (nonatomic, strong) UITableView *mainTableView;


@property (nonatomic, strong) NSArray *testStrArr;
@property (nonatomic, strong) NSArray *testDetailArr;


@end

@implementation SQHousingCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //test
    self.testStrArr = @[@[@"所在小区",@"所在楼栋",@"所在单元",@"所在楼层",@"所在房间",@"我的身份",@"其他信息"],@[@"家有老人",@"残障人士",@"家有小孩",@"家有宠物"]];
    self.testDetailArr = @[@[@"华澳中心",@"10号楼",@"1单元",@"26楼",@"26E",@"房主",@"面积:100m² 物业费:2.5元/m²"],@[@"1",@"2",@"3",@"4"]];
    
    [self setupUI];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainTableView.frame = CGRectMake(0, 0, SQ_ScreenWidth, SQ_ScreenHeight-64);
    [self.view addSubview:_mainTableView];
    
    
}

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
    return self.testStrArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.canEdit?[self.testStrArr[section] count]-1:[self.testStrArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQCertificationCell *cell = [[SQCertificationCell alloc]init];
    cell.testStr = self.testStrArr[indexPath.section][indexPath.row];
    cell.testDetail = self.testDetailArr[indexPath.section][indexPath.row];
    if (self.canEdit) {
        cell.canPush = YES;
        cell.canSelected = indexPath.section;
    }
    if (indexPath.section == 1) {
        cell.canPush = YES;
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_Fit(30))];
    label.text = @"以下为居委会关照信息(选填)";
    label.font = SQ_Font(SQ_Fit(15));
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?SQ_Fit(50):0.01;
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
     SQ_NSLog(@"%zd组 %zd行",indexPath.section,indexPath.row);
}


#pragma mark
#pragma mark SQLocationViewControllerDelegate代理方法
-(void)locationView:(SQLocationViewController *)locationView withLocationStr:(NSString *)locationStr{
    
    SQ_NSLog(@"%@",locationStr);
}



@end
