//
//  SQGoodsListController.m
//  ired6
//
//  Created by zhangchong on 2017/2/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQGoodsListController.h"
#import "SQGoodsListCell.h"
#import "GridListModel.h"
#import "NSObject+Property.h"
#import "SQGoodsDetailsController.h"


@interface SQGoodsListController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;//页面数据
@property (nonatomic, strong) UIButton *swithBtn;//切换视图按钮
@property (nonatomic, strong) UIView *toolView;//排序按钮视图
@property (nonatomic, strong) NSMutableArray<UIButton*> *toolsBtnArray;//存放排序按钮数组
@property (nonatomic, strong) UIButton *selectedToolBtn;//当前点击的排序按钮
@property (nonatomic,assign) CGFloat currentContentOffset;//当前滚动偏移量
@property (nonatomic,assign) BOOL isGrid;//是否为大网格视图类型

@end

@implementation SQGoodsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
    
    [self toolsButtonClick:self.toolsBtnArray.firstObject];
}

#pragma mark
#pragma mark 页面搭建
-(void)setupUI{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.isGrid = YES;
    self.title = @"列表网络视图切换";
    self.view.backgroundColor = [UIColor getColor:@"f2f2f2"];
 
    //商品列表
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flowlayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerClass:[SQGoodsListCell class] forCellWithReuseIdentifier:@"GridListCollectionViewCell"];
    [self.view addSubview:_collectionView];
    
    
    //工具条
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SQ_ScreenWidth, SQ_Fit(30))];
    toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolView];
    self.toolView = toolView;
    
    //切换网格类型按钮
    UIButton *swithBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    swithBtn.frame = CGRectMake(toolView.width-toolView.height, 0, toolView.height, toolView.height);
    [swithBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"product_list_list_btn"] toSize:CGSizeMake(toolView.height/2, toolView.height/2)] forState:UIControlStateNormal];
    [swithBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"product_list_grid_btn"] toSize:CGSizeMake(toolView.height/2, toolView.height/2)] forState:UIControlStateSelected];
    [swithBtn addTarget:self action:@selector(swithBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:swithBtn];

    //排序按钮
    NSArray *toolsArr = @[@"综合",@"销量",@"价格"];
    for (NSInteger i = 0; i < toolsArr.count; i++) {
        CGFloat width = (toolView.width-swithBtn.width)/toolsArr.count;
        UIButton *toolBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [toolBtn setTitle:toolsArr[i] forState:UIControlStateNormal];
        [toolBtn setTitleColor:[UIColor getColor:@"343434"] forState:UIControlStateNormal];
        [toolBtn setTitleColor:[UIColor getColor:@"fb4142"] forState:UIControlStateSelected];
        toolBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
        toolBtn.frame = CGRectMake(i*width, 0, width, toolView.height);
        [toolView addSubview:toolBtn];
        [toolBtn addTarget:self action:@selector(toolsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolsBtnArray addObject:toolBtn];
    }
}
//****************以下为测试数据******************//
-(void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *products = dict[@"wareInfo"];
    for (id obj in products) {
        [self.dataArr addObject:[GridListModel objectWithDictionary:obj]];
    }
}
//****************以上为测试数据******************//
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)toolsBtnArray{
    if (!_toolsBtnArray) {
        _toolsBtnArray = [NSMutableArray new];
    }
    return _toolsBtnArray;
}
#pragma mark
#pragma mark UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SQGoodsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridListCollectionViewCell" forIndexPath:indexPath];
    cell.isGrid = _isGrid;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)collectionViewLayout;
    flowLayout.sectionInset = UIEdgeInsetsMake(SQ_Fit(5)+self.toolView.height, 0, SQ_Fit(5), 0);
    if (_isGrid) {
        flowLayout.minimumLineSpacing = SQ_Fit(5);
        flowLayout.minimumInteritemSpacing = SQ_Fit(5);
        return CGSizeMake((SQ_ScreenWidth-SQ_Fit(5))/2, SQ_Fit(280));
    } else {
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        return CGSizeMake(SQ_ScreenWidth, SQ_Fit(100));
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SQGoodsDetailsController *goodsDetailVC = [[SQGoodsDetailsController alloc]init];
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
    
}
#pragma mark
#pragma mark UIScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat content = scrollView.contentOffset.y;
    
    if (content > self.currentContentOffset+self.toolView.height) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.toolView.y = 64-self.toolView.height;
        }];
    }
    if (content < self.currentContentOffset-self.toolView.height) {
    
        [UIView animateWithDuration:0.5 animations:^{
            self.toolView.y = 64;
        }];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.currentContentOffset = scrollView.contentOffset.y;

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.currentContentOffset = scrollView.contentOffset.y;
}


#pragma mark
#pragma mark 按钮点击方法
- (void)swithBtnClick:(UIButton*)sender
{
    _isGrid = !_isGrid;
    sender.selected = !sender.selected;
    [self.collectionView reloadData];
    
}
-(void)toolsButtonClick:(UIButton*)sender{
    
    self.selectedToolBtn.selected = NO;
    self.selectedToolBtn.userInteractionEnabled = YES;
    
    sender.selected = !sender.selected;
    self.selectedToolBtn = sender;
    sender.userInteractionEnabled = NO;
    [[SQPublicTools sharedPublicTools]showMessage:sender.titleLabel.text duration:3];
}
@end
