//
//  SQAttestViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/13.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQAttestViewController.h"
#import "SQHousingCertificationController.h"

@interface SQAttestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *attestBtnArr;
@property (nonatomic, strong) UIImageView *triangleView;
@property (nonatomic, strong) UITableView *attestListView;

@end

@implementation SQAttestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"认证管理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}
-(void)setupUI{
    
    //认证按钮
    NSArray *btnArr = @[@"房屋认证",@"身份认证"];
    for (NSInteger i = 0; i < btnArr.count; i++) {
        UIButton *attestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attestBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [attestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        attestBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
        [attestBtn setBackgroundColor:[UIColor getColor:@"fb4142"]];
        [attestBtn addTarget:self action:@selector(attestButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [attestBtn sizeToFit];
        CGFloat btnMargin = (SQ_ScreenWidth - btnArr.count*attestBtn.width)/(btnArr.count+1);
        attestBtn.x = btnMargin+(btnMargin+attestBtn.width)*i;
        attestBtn.y = SQ_Fit(20);
        [self.view addSubview:attestBtn];
        
        if (i == 0) {
            //滑动小三角
            UIImageView *triangleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"service_triangle_up"]];
            triangleView.bounds = CGRectMake(0, 0, SQ_Fit(20), SQ_Fit(20));
            triangleView.centerX = attestBtn.centerX;
            triangleView.y = CGRectGetMaxY(attestBtn.frame);
            [self.view addSubview:triangleView];
            self.triangleView = triangleView;
        }
    }
    
    UIButton *newAttest = [UIButton buttonWithType:UIButtonTypeCustom];
    newAttest.frame = CGRectMake(0, SQ_ScreenHeight-64-SQ_Fit(50), SQ_ScreenWidth, SQ_Fit(50));
    [newAttest setBackgroundColor:[UIColor getColor:@"fb4142"]];
    [newAttest setTitle:@"新增认证" forState:UIControlStateNormal];
    [newAttest setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    newAttest.titleLabel.font = SQ_Font(SQ_Fit(15));
    [self.view addSubview:newAttest];
    [newAttest addTarget:self action:@selector(newAttestButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITableView *attestListView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.triangleView.frame), SQ_ScreenWidth, newAttest.y-CGRectGetMaxY(self.triangleView.frame))];
    attestListView.delegate = self;
    attestListView.dataSource = self;
    attestListView.bounces = NO;
    attestListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [attestListView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AttestListTableViewCellID"];
    [self.view addSubview:attestListView];
    self.attestListView = attestListView;
}
-(void)attestButtonClick:(UIButton*)sender{
    
    self.triangleView.centerX = sender.centerX;
    [self.attestListView reloadData];
}

#pragma mark 
#pragma mark TableviewDelegate代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.triangleView.centerX<(SQ_ScreenWidth/2)?10:10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttestListTableViewCellID" forIndexPath:indexPath];
    cell.backgroundColor = SQ_GlobalRBG;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行数据-%@",indexPath.row,self.triangleView.centerX<(SQ_ScreenWidth/2)?@"房屋认证":@"身份认证"];
    cell.textLabel.font = SQ_Font(SQ_Fit(15));
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.triangleView.centerX<(SQ_ScreenWidth/2)?SQ_Fit(80):SQ_Fit(100);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.triangleView.centerX<(SQ_ScreenWidth/2)) {
        SQHousingCertificationController *houseVC = [[SQHousingCertificationController alloc]init];
        houseVC.canEdit = NO;
        houseVC.title = @"房屋认证";
        [self.navigationController pushViewController:houseVC animated:YES];
    }else{
        
        [[SQPublicTools sharedPublicTools]showMessage:@"身份认证建设中" duration:3];
    }
}
#pragma mark
#pragma mark 按钮方法实现
-(void)newAttestButtonClick:(UIButton*)sender{
    
    if (self.triangleView.centerX<(SQ_ScreenWidth/2)){
        SQHousingCertificationController *houseVC = [[SQHousingCertificationController alloc]init];
        houseVC.canEdit = YES;
        houseVC.title = @"新增房屋认证";
        [self.navigationController pushViewController:houseVC animated:YES];
        
    }else{
        [[SQPublicTools sharedPublicTools]showMessage:@"新增身份认证建设中" duration:3];
    }
}
@end
