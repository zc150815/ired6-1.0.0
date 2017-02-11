//
//  SQGoodsClassificationController.m
//  ired6
//
//  Created by zhangchong on 2017/2/7.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQGoodsClassificationController.h"
#import "SQGoodsClassificationModel.h"
#import "SQTopCategoryCell.h"
#import "SQThirdCategoryCell.h"
#import "SQGoodsListController.h"

@interface SQGoodsClassificationController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSArray *SubCategoryArray;
@property (nonatomic, strong) NSMutableArray *ThirdCategoryArray;

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UICollectionView *rightCollectionView;
@property (nonatomic, strong) UILabel *headerLab;

@end

@implementation SQGoodsClassificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

#pragma mark
#pragma mark 懒加载数据
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}
-(NSArray *)SubCategoryArray{
    if (!_SubCategoryArray) {
        _SubCategoryArray = [NSArray new];
    }
    return _SubCategoryArray;
}
-(NSMutableArray *)ThirdClassArr{
    if (!_ThirdCategoryArray) {
        _ThirdCategoryArray = [NSMutableArray new];
    }
    return _ThirdCategoryArray;
}

#pragma mark 页面搭建
-(void)setupUI{
    
    self.view.backgroundColor = [UIColor getColor:@"f2f2f2"];
    
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SQ_Fit(100), SQ_ScreenHeight)];
    _leftTableView.rowHeight = SQ_Fit(50);
    _leftTableView.bounces = NO;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.showsHorizontalScrollIndicator = NO;
    _leftTableView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_leftTableView registerClass:[SQTopCategoryCell class] forCellReuseIdentifier:@"LeftTableViewID"];
    [self.view addSubview:_leftTableView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(_leftTableView.width, 0, SQ_ScreenWidth-_leftTableView.width, SQ_ScreenHeight) collectionViewLayout:flowLayout];
    _rightCollectionView.delegate = self;
    _rightCollectionView.dataSource = self;
    _rightCollectionView.bounces = NO;
    _rightCollectionView.showsVerticalScrollIndicator = NO;
    _rightCollectionView.showsHorizontalScrollIndicator = NO;
    _rightCollectionView.backgroundColor = [UIColor getColor:@"f2f2f2"];
    [_rightCollectionView registerClass:[SQThirdCategoryCell class] forCellWithReuseIdentifier:@"RightCollectionViewCellID"];
    [_rightCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewIdentifier"];
    [self.view addSubview:_rightCollectionView];
}

#pragma mark 网络数据获取
-(void)loadData{
    
    [[SQNetworkingTools sharedNetWorkingTools]getGoodsClassificationDataWithCallBack:^(id response, NSError *error) {
        if (error) {
            [[SQPublicTools sharedPublicTools]showMessage:@"数据获取错误" duration:3];
            return;
        }
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            self.dataArr = [SQGoodsClassificationModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            
            [self.leftTableView reloadData];
            [self tableView:self.leftTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        }
    }];
}



#pragma mark
#pragma mark UITableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count?self.dataArr.count:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQTopCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftTableViewID" forIndexPath:indexPath];
    SQGoodsClassificationModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        SQGoodsClassificationModel *leftModel = self.dataArr[i];
        if (i == indexPath.row) {
            leftModel.isSelected = YES;
        }else{
            leftModel.isSelected = NO;
        };
    }
    [self.leftTableView reloadData];
    
    SQGoodsClassificationModel *model = self.dataArr[indexPath.row];
    self.SubCategoryArray = [SQGoodsClassificationModel mj_objectArrayWithKeyValuesArray:model.FirstCategory];
    [self.rightCollectionView reloadData];

}



#pragma mark
#pragma mark UICollectionView代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return  self.SubCategoryArray.count?self.SubCategoryArray.count:0;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    SQGoodsClassificationModel *model = self.SubCategoryArray[section];
    return model.SubCategory.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SQThirdCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RightCollectionViewCellID" forIndexPath:indexPath];
    
    SQGoodsClassificationModel *model = self.SubCategoryArray[indexPath.section];
    cell.model = model;

    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)collectionViewLayout;
    
    flowLayout.minimumLineSpacing = SQ_Fit(10);
    flowLayout.minimumInteritemSpacing = SQ_Fit(10);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, SQ_Fit(10), 0, SQ_Fit(10));
    flowLayout.headerReferenceSize = CGSizeMake(collectionView.width, SQ_Fit(30)); //设置collectionView头视图的大小
    CGFloat itemWidth = (collectionView.width-SQ_Fit(10)*4)/3;
    CGFloat itemHeight = SQ_Fit(100);
    return CGSizeMake(itemWidth, itemHeight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SQGoodsListController *goodsListVC = [[SQGoodsListController alloc]init];
    [self.navigationController pushViewController:goodsListVC animated:YES];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    self.headerLab = nil;
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerViewIdentifier" forIndexPath:indexPath];
        [header.subviews.firstObject removeFromSuperview];
        [self collectionView:collectionView addHeaderViewWithIndexPath:indexPath];
        [header addSubview:_headerLab];
        return header;
    }
    //如果底部视图
    //    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
    //
    //    }
    return nil;
}
-(void)collectionView:(UICollectionView*)collectionView addHeaderViewWithIndexPath:(NSIndexPath*)indexPath{
    
    SQGoodsClassificationModel *model = self.SubCategoryArray[indexPath.section];
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(SQ_Fit(10), 0, collectionView.width, SQ_Fit(30))];
    headerLab.text = model.SubName;
    headerLab.backgroundColor = [UIColor clearColor];
    headerLab.font = SQ_Font(SQ_Fit(14));
    self.headerLab = headerLab;
}
@end
