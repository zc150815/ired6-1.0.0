//
//  SQLocationViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/13.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQLocationViewController.h"
#import "SQNavigationController.h"

@interface SQLocationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *detailAddress;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIButton *cityBtn;

@end

@implementation SQLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小区选择";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}
-(void)setupUI{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //城市选择按钮
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cityBtn setTitle:[defaults objectForKey:CityName] forState:UIControlStateNormal];
    cityBtn.titleLabel.font = SQ_Font(14);
    cityBtn.adjustsImageWhenHighlighted = NO;
    [cityBtn setImage:[UIImage imageNamed:@"fragment_community_select"] forState:UIControlStateNormal];
    [cityBtn sizeToFit];
    [cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -cityBtn.imageView.size.width, 0, cityBtn.imageView.size.width)];
    [cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, cityBtn.titleLabel.bounds.size.width, 0, -cityBtn.titleLabel.bounds.size.width)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cityBtn];
    self.cityBtn = cityBtn;
    [cityBtn addTarget:self action:@selector(cityChooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, 50)];
    searchBar.placeholder = @"请输入小区、写字楼名称";
    [self.view addSubview:searchBar];
    
    //按钮文字格式
    NSMutableAttributedString *detailStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"当前位置: %@",[defaults objectForKey:FullAddress]]];
    NSRange range = {0, 5};
    NSRange range1 = {5, detailStr.string.length-5};
    [detailStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [detailStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    
    //地址详情按钮
    UIButton *detailAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailAddress setAttributedTitle:detailStr forState:UIControlStateNormal];
    [detailAddress setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [detailAddress setImageEdgeInsets:UIEdgeInsetsMake(0, -SQ_BaseMargin/2, 0, SQ_BaseMargin/2)];
    detailAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [detailAddress sizeToFit];
    detailAddress.frame = CGRectMake(0, CGRectGetMaxY(searchBar.frame)+SQ_Fit(20), SQ_ScreenWidth, SQ_Fit(20));
    detailAddress.imageView.size = detailAddress.currentImage.size;
    detailAddress.userInteractionEnabled = NO;
    detailAddress.titleLabel.font = SQ_Font(SQ_Fit(13));
    [self.view addSubview:detailAddress];
    self.detailAddress = detailAddress;
    
    
    //附近小区列表
    UITableView *recommendTableView= [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(detailAddress.frame)+SQ_Fit(20), SQ_ScreenWidth, SQ_ScreenHeight-CGRectGetMaxY(detailAddress.frame)-SQ_Fit(20)-64) style:UITableViewStylePlain];
    recommendTableView.delegate = self;
    recommendTableView.dataSource = self;
    recommendTableView.bounces = NO;
    recommendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [recommendTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RecommendTableViewID"];
    [self.view addSubview:recommendTableView];
}

#pragma mark
#pragma mark TableviewDelegate代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendTableViewID" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd号小区",indexPath.row];
    cell.textLabel.font = SQ_Font(SQ_Fit(16));
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *selectedStr =[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    if ([self.delegate respondsToSelector:@selector(locationView:withLocationStr:)]) {
        [self.delegate locationView:self withLocationStr:selectedStr];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
    if ([self.delegate isKindOfClass:[SQNavigationController class]]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:selectedStr forKey:CommunityName];
        [defaults synchronize];
        NSNotificationCenter *notifi = [NSNotificationCenter defaultCenter];
        [notifi postNotificationName:@"LocationFinishedNotification" object:self];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SQ_Fit(50);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}
#pragma mark
#pragma mark 按钮点击方法

-(void)cityChooseButtonClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.view addSubview:self.coverView];
    }else{
        [self.coverView removeFromSuperview];
    }

}
-(void)cityChooseFinished:(UITapGestureRecognizer*)tapGesture{
    
    [self cityChooseButtonClick:self.cityBtn];
}
-(void)cityButtonClick:(UIButton*)sender{
    
    [_cityBtn setTitle:[NSString stringWithFormat:@"%@市",sender.titleLabel.text] forState:UIControlStateNormal];
    [_cityBtn sizeToFit];
    [_cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -_cityBtn.imageView.size.width, 0, _cityBtn.imageView.size.width)];
    [_cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _cityBtn.titleLabel.bounds.size.width, 0, -_cityBtn.titleLabel.bounds.size.width)];
    [self cityChooseButtonClick:_cityBtn];

}
#pragma mark
#pragma mark 懒加载数据
-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityChooseFinished:)];
        [_coverView addGestureRecognizer:tapGesture];
        
        UIView *mainView = [[UIView alloc]init];
        mainView.backgroundColor = [UIColor getColor:@"f2f2f2"];
        [_coverView addSubview:mainView];
        
        NSInteger btnCount = 4;
        CGFloat btnWidth = (SQ_ScreenWidth-5*SQ_Fit(15))/btnCount;
        CGFloat btnHeight = SQ_Fit(40);
        CGFloat margin = (SQ_ScreenWidth-btnCount*btnWidth)/(btnCount+1);
        
        UILabel *openCityLab = [[UILabel alloc]init];
        openCityLab.text = @"已开通城市";
        openCityLab.font = SQ_Font(SQ_Fit(16));
        openCityLab.textColor = [UIColor getColor:@"343434"];
        [openCityLab sizeToFit];
        openCityLab.x = margin;
        openCityLab.y = SQ_Fit(20);
        [mainView addSubview:openCityLab];
        
        NSArray *cityArr = @[@"北京",@"上海",@"广州",@"淄博",@"乌鲁木齐",@"邯郸"];
        for (NSInteger i = 0; i < cityArr.count; i++) {
            NSInteger loc = i%btnCount;
            NSInteger row = i/btnCount;
            CGFloat btnX = margin+loc*(margin+btnWidth);
            CGFloat btnY = margin+row*(margin+btnHeight)+CGRectGetMaxY(openCityLab.frame);
            
            UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cityBtn setBackgroundColor:[UIColor whiteColor]];
            [cityBtn setTitle:cityArr[i] forState:UIControlStateNormal];
            [cityBtn setTitleColor:[UIColor getColor:@"343434"] forState:UIControlStateNormal];
            cityBtn.titleLabel.font = SQ_Font(SQ_Fit(16));
            cityBtn.layer.borderWidth = 1;
            cityBtn.layer.borderColor = [UIColor getColor:@"cccccc"].CGColor;
            cityBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            [mainView addSubview:cityBtn];
            [cityBtn addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == cityArr.count-1) {
                mainView.frame = CGRectMake(0, 0, SQ_ScreenWidth, CGRectGetMaxY(cityBtn.frame)+margin);
            }
        }
    }
    return _coverView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
