//
//  SQAttestViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/13.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQAttestViewController.h"
#import "SQHousingCertificationController.h"
#import "SQIdentityCertificationController.h"
#import "SQAttestCell.h"
#import "SQAttestListModel.h"

@interface SQAttestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *attestListView;//主体tableview
@property (nonatomic, strong) UIButton *oldButton;//上一次被点击按钮
@property (nonatomic, strong) UIButton *addNewAttest;//新增认证按钮
@property (nonatomic, strong) UIImageView *triangleView;//当前页面标记

@property (nonatomic, strong) NSArray *dataArr1;//数据源1
@property (nonatomic, strong) NSArray *dataArr2;//数据源2



@end

@implementation SQAttestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
    [self attestButtonClick:self.oldButton];
}

//加载网络数据
-(void)loadData{
    
    NSArray *array1 = @[
                        @{@"isAttested":@"1",@"titleStr":@"华澳中心3号楼26E",@"detailStr":@"北京市海淀区紫竹院路31号",@"additionalStr":@"房屋面积:108.55m²",@"attestedNum":@"5",},
                        @{@"isAttested":@"0",@"titleStr":@"美林家园3012室",@"detailStr":@"北京市海淀区紫竹院路31号",@"additionalStr":@"房屋面积:105m²",@"attestedNum":@"5",}
                        ];
    NSArray *array2 = @[
                        @{@"isAttested":@"1",@"titleStr":@"实名认证",@"additionalStr":@"姓名:张洋"},
                        @{@"isAttested":@"0",@"titleStr":@"社区管理",@"additionalStr":@"负责区域:华澳中心小区"}
                        ];
    
    self.dataArr1 = [SQAttestListModel mj_objectArrayWithKeyValuesArray:array1];
    self.dataArr2 = [SQAttestListModel mj_objectArrayWithKeyValuesArray:array2];
    
}
-(void)setupUI{
    
    self.title = @"认证管理";
    self.view.backgroundColor = [UIColor getColor:@"f2f2f2"];
    //认证按钮
    NSArray *btnArr = @[@"房屋认证",@"身份认证"];
    for (NSInteger i = 0; i < btnArr.count; i++) {
        UIButton *attestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attestBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [attestBtn setTitleColor:[UIColor getColor:@"343434"] forState:UIControlStateNormal];
        [attestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        attestBtn.layer.borderColor = [UIColor getColor:@"cccccc"].CGColor;
        attestBtn.layer.borderWidth = SQ_Fit(1);
        attestBtn.titleLabel.font = SQ_Font(SQ_Fit(16));
        [attestBtn setBackgroundColor:[UIColor whiteColor]];
        [attestBtn addTarget:self action:@selector(attestButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        attestBtn.width = SQ_Fit(120);
        attestBtn.height = SQ_Fit(48);
        attestBtn.y = SQ_Fit(20);
        attestBtn.x = i?self.view.centerX:self.view.centerX-attestBtn.width;
        [self.view addSubview:attestBtn];
        if (i == 0) {
            self.oldButton = attestBtn;
            _triangleView = [[UIImageView alloc]initWithFrame:CGRectMake(attestBtn.centerX, attestBtn.centerY, 1, 1)];
            _triangleView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:_triangleView];
        }
    }
    
    
    _addNewAttest = [UIButton buttonWithType:UIButtonTypeCustom];
    _addNewAttest.frame = CGRectMake(0, SQ_ScreenHeight-64-SQ_Fit(48), SQ_ScreenWidth, SQ_Fit(48));
    [_addNewAttest setBackgroundColor:[UIColor getColor:@"fb4142"]];
    [_addNewAttest setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addNewAttest.titleLabel.font = SQ_Font(SQ_Fit(16));
    [self.view addSubview:_addNewAttest];
    [_addNewAttest addTarget:self action:@selector(newAttestButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _attestListView = [[UITableView alloc]initWithFrame:CGRectMake(0, SQ_Fit(88), SQ_ScreenWidth, _addNewAttest.y-SQ_Fit(88))];
    _attestListView.delegate = self;
    _attestListView.dataSource = self;
    _attestListView.bounces = NO;
    _attestListView.rowHeight = UITableViewAutomaticDimension;
    _attestListView.estimatedRowHeight = 50;
    _attestListView.backgroundColor = [UIColor clearColor];
    _attestListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_attestListView registerClass:[SQAttestCell class] forCellReuseIdentifier:@"AttestListTableViewCellID"];
    [self.view addSubview:_attestListView];

}


#pragma mark 
#pragma mark TableviewDelegate代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.triangleView.centerX<(SQ_ScreenWidth/2)?self.dataArr1.count:self.dataArr2.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQAttestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttestListTableViewCellID" forIndexPath:indexPath];
    cell.model = self.triangleView.centerX<(SQ_ScreenWidth/2)?self.dataArr1[indexPath.row]:self.dataArr2[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.triangleView.centerX<(SQ_ScreenWidth/2)?SQ_Fit(110):SQ_Fit(80);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.triangleView.centerX<(SQ_ScreenWidth/2)) {
        SQHousingCertificationController *houseVC = [[SQHousingCertificationController alloc]init];
        houseVC.canEdit = NO;
        houseVC.title = @"房屋认证";
        houseVC.model = self.dataArr1[indexPath.row];
        [self.navigationController pushViewController:houseVC animated:YES];
    }else{
//        SQIdentityCertificationController *identityVC = [[SQIdentityCertificationController alloc]init];
//        identityVC.canEdit = NO;
//        identityVC.title = @"身份认证";
//        identityVC.model = self.dataArr2[indexPath.row];
//        [self.navigationController pushViewController:identityVC animated:YES];
    }
}

#pragma mark
#pragma mark 按钮方法实现
//新增认证按钮点击事件
-(void)newAttestButtonClick:(UIButton*)sender{
    
    if (self.triangleView.centerX<(SQ_ScreenWidth/2)) {
        SQHousingCertificationController *houseVC = [[SQHousingCertificationController alloc]init];
        houseVC.canEdit = YES;
        houseVC.title = @"新增房屋认证";
        [self.navigationController pushViewController:houseVC animated:YES];
    }else{
        SQIdentityCertificationController *identityVC = [[SQIdentityCertificationController alloc]init];
        identityVC.title = @"新增身份认证";
        [self.navigationController pushViewController:identityVC animated:YES];
    }
}
//认证列表切换按钮点击事件
-(void)attestButtonClick:(UIButton*)sender{
    _oldButton.selected = NO;
    [_oldButton setBackgroundColor:[UIColor whiteColor]];
    _oldButton.layer.borderWidth = SQ_Fit(1);
    
    sender.selected = YES;
    [sender setBackgroundColor:[UIColor getColor:@"fb4142"]];
    sender.layer.borderWidth = 0;
    
    _oldButton = sender;
    _triangleView.centerX = sender.centerX;
    [_attestListView reloadData];
    
    [_addNewAttest setTitle:_triangleView.centerX<(SQ_ScreenWidth/2)?@"新增房屋":@"新增身份" forState:UIControlStateNormal];
}

@end
