//
//  SQShoppingViewController.m
//  ired6
//
//  Created by zhangchong on 2017/1/9.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import "SQShoppingViewController.h"
#import "BottomPriceView.h"
#import "GoodsToolBar.h"
#import "SQShoppingCartShopCell.h"
#import "SQShoppingCartGoodsCell.h"
#import "SQShoppingCartModel.h"

@interface SQShoppingViewController ()<UITableViewDelegate,UITableViewDataSource,BottomPriceViewDelegate,GoodsToolBarDelegate,SQShoppingCartShopCellDelegate,SQShoppingCartGoodsCellDelegate>

@property (nonatomic, strong) UITableView *shoppingCart;//主体页面
@property (nonatomic, strong) BottomPriceView *bottomPriceView;//底部结算按钮
@property (nonatomic, strong) UIView *goodsToolBar;//键盘工具视图


@property (nonatomic, assign) double allSum;//总价格

@property (nonatomic, strong) NSMutableArray *dataArr;//列表数据
@property (nonatomic, strong) NSMutableArray *shopNameArray;//店铺名称数据
@property (nonatomic, strong) NSMutableArray *selectedShopArray;//被选中店铺
@property (nonatomic, strong) NSMutableDictionary *shopCartDic;//商品数据
@property (nonatomic, strong) NSMutableArray *selectedArray;//被选中商品数据

@end

@implementation SQShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self loadData];
}

#pragma mark
#pragma mark 懒加载数据
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        
    }
    return _dataArr;
}
//店铺名称数据
-(NSMutableArray *)shopNameArray{
    if (!_shopNameArray) {
        _shopNameArray = [NSMutableArray new];
    }
    return _shopNameArray;
}
//被选中的店铺
- (NSMutableArray *)selectedShopArray{
    if (!_selectedShopArray) {
        _selectedShopArray = [NSMutableArray new];
    }
    return _selectedShopArray;
}
//一个key对应该商店的所有商品
- (NSMutableDictionary *)shopCartDic{
    if (!_shopCartDic) {
        _shopCartDic = [NSMutableDictionary new];
    }
    return _shopCartDic;
}
//被选中的商品
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }
    return _selectedArray;
}

#pragma mark 读取网络数据
-(void)loadData{
    
    [self.selectedArray removeAllObjects];
    [self.selectedShopArray removeAllObjects];
    [self.dataArr removeAllObjects];
    self.bottomPriceView.isSelectBtn = NO;
    self.bottomPriceView.hidden = YES;

    [[SQNetworkingTools sharedNetWorkingTools]getShoppingCartDataWithCallBack:^(id response, NSError *error) {
        
        if (error) {
            [[SQPublicTools sharedPublicTools]showMessage:@"数据获取错误" duration:3];
            [self.shoppingCart.mj_header endRefreshing];

            return;
        }
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)response;
            NSArray *dataArray = dic[@"data"];
            
            //店铺数据模型
            for (NSDictionary *dic in dataArray) {
                SQShoppingCartModel *model = [SQShoppingCartModel mj_objectWithKeyValues:dic];
                if (![self.shopNameArray containsObject:model.store_name]) {
                    [self.shopNameArray addObject:model.store_name];
                }
            }
            
            //商品数据模型
            self.dataArr = [SQShoppingCartModel mj_objectArrayWithKeyValuesArray: dataArray];
            for (NSString *shopName in self.shopNameArray) {
                NSMutableArray *array = [NSMutableArray new];
                for (SQShoppingCartModel *model in self.dataArr) {
                    if ([model.store_name isEqualToString:shopName]) {
                        [array addObject:model];
                    }
                }
                //以店铺名为key的商品字典
                [self.shopCartDic setObject:array forKey:shopName];
            }
            [self.shoppingCart reloadData];
            [self.shoppingCart.mj_header endRefreshing];
        }
    }];
}
#pragma mark 页面布局
-(void)setupUI{
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *shoppingCart = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SQ_ScreenWidth, SQ_ScreenHeight) style:UITableViewStyleGrouped];
    shoppingCart.delegate = self;
    shoppingCart.dataSource = self;
    shoppingCart.separatorStyle = UITableViewCellSeparatorStyleNone;
    shoppingCart.showsVerticalScrollIndicator = NO;
    shoppingCart.showsHorizontalScrollIndicator = NO;
    [shoppingCart setContentInset:UIEdgeInsetsMake(0, 0, SQ_Fit(40), 0)];
    [shoppingCart registerClass:[SQShoppingCartShopCell class] forCellReuseIdentifier:@"ShopCellID"];
    [shoppingCart registerClass:[SQShoppingCartGoodsCell class] forCellReuseIdentifier:@"GoodsCellID"];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];//下拉刷新控件
    header.automaticallyChangeAlpha = YES;   // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    shoppingCart.mj_header = header;
    
    [self.view addSubview:shoppingCart];
    self.shoppingCart = shoppingCart;
    

    BottomPriceView *bottomPriceView = [[BottomPriceView alloc]initWithFrame:CGRectMake(0, SQ_ScreenHeight-49-SQ_Fit(40),SQ_ScreenWidth,SQ_Fit(40))];
    bottomPriceView.hidden = YES;
    bottomPriceView.delegate = self;
    [self.view addSubview:bottomPriceView];
    self.bottomPriceView = bottomPriceView;
    
    GoodsToolBar *goodsToolBar = [[GoodsToolBar alloc]initWithFrame:CGRectMake(0, SQ_ScreenHeight, SQ_ScreenWidth, SQ_Fit(30))];
    goodsToolBar.delegate = self;
    [self.view addSubview:goodsToolBar];
    self.goodsToolBar = goodsToolBar;
    
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
#pragma mark
#pragma mark UITableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.shopNameArray.count != 0) {
        _bottomPriceView.hidden = NO;
        if (!self.shoppingCart.contentInset.bottom) {
            [self.shoppingCart setContentInset:UIEdgeInsetsMake(0, 0, SQ_Fit(40), 0)];
        }
        return self.shopNameArray.count;
    }
    if (self.shopNameArray.count == 0) {
      
        _bottomPriceView.hidden = YES;
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.shopNameArray.count) {
        NSArray *array = [self.shopCartDic objectForKey:self.shopNameArray[section]];
        return array.count+1;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.shopNameArray.count) {
        NSMutableArray *array = [self.shopCartDic objectForKey:self.shopNameArray[indexPath.section]];

        if (indexPath.row == 0) {//店铺
            SQShoppingCartShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCellID" forIndexPath:indexPath];
            SQShoppingCartModel *model = array[indexPath.row];
            cell.model = model;
            cell.delegate = self;
            if ([self.selectedShopArray containsObject:model.store_name]) {
                cell.selectedBtn.selected = YES;
            }else{
                cell.selectedBtn.selected = NO;
            }
            return cell;
        }else{//商品
            SQShoppingCartGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCellID" forIndexPath:indexPath];
            SQShoppingCartModel *model = array[indexPath.row-1];
            cell.model = model;
            cell.delegate = self;
            return cell;
        }

        
    }else{
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.textLabel.text = @"购物车空空如也\n\n快去挑几件好货吧!";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.numberOfLines = 0;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.shopNameArray.count) {
        if (indexPath.row == 0) {
            return SQ_Fit(30);
        }else{
            return SQ_Fit(100);
        }
    }
    return SQ_ScreenHeight/2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SQ_Fit(10);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [[SQPublicTools sharedPublicTools]showMessage:[NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row] duration:3];
    }else{
        [[SQPublicTools sharedPublicTools]showMessage:[NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row] duration:3];
    }
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置删除按钮
    if (indexPath.row != 0) {
        
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
            //删除操作 给后台发送删除请求
            //删除 缓存数据
            //1.取出对应的商店的所有商品数组
            NSMutableArray *array = [self.shopCartDic objectForKey:self.shopNameArray[indexPath.section]];
            //2.0删除对应商品
            SQShoppingCartModel *model = array[indexPath.row - 1];
            [array removeObjectAtIndex:(indexPath.row - 1)];
            //2.1删除已选中商品
            if ([self.selectedArray containsObject:model]) {
                [self.selectedArray removeObject:model];
            }
            if (array.count == 0) {
                //删除已选中商店
                if ([self.selectedShopArray containsObject:model.store_name]) {
                    [self.selectedShopArray removeObject:model.store_name];
                }
                [self.shopCartDic removeObjectForKey:self.shopNameArray[indexPath.section]];
                [self.shopNameArray removeObjectAtIndex:indexPath.section];
            }else{
                BOOL isSelect = YES;
                [self.shopCartDic setObject:array forKey:self.shopNameArray[indexPath.section]];
                //看该商店的所有商品是否都在已选里面
                for (SQShoppingCartModel *temp in array) {
                    if (![self.selectedArray containsObject:temp]) {
                        isSelect = NO;
                    }
                }
                //添加商店
                if (isSelect) {
                    if (![self.selectedShopArray containsObject:model.store_name]) {
                        [self.selectedShopArray addObject:model.store_name];
                    }
                }
            }
            [self.dataArr removeObject:model];
            //看是否全选中
            NSSet *s1 = [[NSSet alloc]initWithArray:self.dataArr];
            NSSet *s2 = [[NSSet alloc] initWithArray:self.selectedArray];
            if ([s1 isEqual:s2]) {
                self.bottomPriceView.selectedBtn.selected = YES;
            }
            [tableView reloadData];
            
            //动态更改合计、数量
            self.allSum = 0;
            for (SQShoppingCartModel *model in self.selectedArray) {
                self.allSum += model.goods_price * model.goods_num;
            }
            _bottomPriceView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
            _bottomPriceView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];

        }];

        return @[deleteRowAction];
    }else{
        return nil;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        return YES;
    }else{
        return NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


#pragma mark BottomPriceView代理方法
-(void)bottomPriceView:(BottomPriceView *)bottomView buttonClickWith:(UIButton *)sender{
    if (sender.tag == 1000) { 
        [[SQPublicTools sharedPublicTools]showMessage:@"全选" duration:3];
        if (sender.selected) {
            [self.selectedArray removeAllObjects];
            [self.selectedArray addObjectsFromArray:self.dataArr];
            for (SQShoppingCartModel *model in self.dataArr) {
                model.isSelect = YES;
            }
            [self.selectedShopArray removeAllObjects];
            [self.selectedShopArray addObjectsFromArray:self.shopNameArray];
            self.allSum = 0.0;
            //计算总价格
            for (SQShoppingCartModel *model in self.selectedArray) {
                self.allSum += model.goods_price * model.goods_num;
            }
        }else{
            [self.selectedArray removeAllObjects];
            [self.selectedShopArray removeAllObjects];
            for (SQShoppingCartModel *model in self.dataArr) {
                model.isSelect = NO;
            }
            self.allSum = 0.0;
        }
        bottomView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
        bottomView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
        [self.shoppingCart reloadData];
        return;
    }
    if (sender.tag == 1001) {
        [[SQPublicTools sharedPublicTools]showMessage:@"结算" duration:3];
        return;
    }
}

#pragma mark GoodsToolBar代理方法
-(void)goodsToolBar:(GoodsToolBar *)goodsToolBar withButtonClick:(UIButton *)sender{
    NSString *btnStr = sender.titleLabel.text;
    if ([btnStr isEqualToString:@"确定"]) {
        [[SQPublicTools sharedPublicTools]showMessage:@"确定" duration:3];
    }else{
        [[SQPublicTools sharedPublicTools]showMessage:@"取消" duration:3];
    }
    [self.view endEditing:YES];
}
#pragma mark SQShoppingCartShopCell代理方法
-(void)shoppingCartShopCell:(SQShoppingCartShopCell *)cell withSelectedModel:(SQShoppingCartModel *)model{
    
    NSMutableArray *array = [self.shopCartDic objectForKey:model.store_name];
    if ([self.selectedShopArray containsObject:model.store_name]) {
        [self.selectedShopArray removeObject:model.store_name];
        for (SQShoppingCartModel *model in array) {
            [self.selectedArray removeObject:model];
            //每当删除商品
            self.bottomPriceView.selectedBtn.selected = NO;
            self.allSum -= model.goods_price * model.goods_num;
            model.isSelect = NO;
        }
    }else{
        [self.selectedShopArray addObject:model.store_name];
        for (SQShoppingCartModel *model in array) {
            if (![self.selectedArray containsObject:model]) {
                [self.selectedArray addObject:model];
                model.isSelect = YES;
                self.allSum += model.goods_price * model.goods_num;
            }
        }
    }
    if (self.selectedShopArray.count == self.shopNameArray.count) {
        //全部店铺添加
        self.bottomPriceView.isSelectBtn = YES;
    }
    self.bottomPriceView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
    self.bottomPriceView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
    [self.shoppingCart reloadData];
}
#pragma mark SQShoppingCartGoodsCell代理方法
-(void)shoppingCartGoodsCell:(SQShoppingCartGoodsCell *)cell withSelectedModel:(SQShoppingCartModel *)model{
    
    if ([self.selectedArray containsObject:model]) {
        [self.selectedArray removeObject:model];
        _bottomPriceView.selectedBtn.selected = NO;
        model.isSelect = NO;
        self.allSum -= model.goods_price * model.goods_num;
    }else{
        [self.selectedArray addObject:model];
        model.isSelect = YES;
        self.allSum += model.goods_price * model.goods_num;
    }
    
    BOOL isExist = YES;
    //被选中的商品商店
    NSArray *array = [self.shopCartDic objectForKey:model.store_name];
    for (SQShoppingCartModel *model in array) {
        if (![self.selectedArray containsObject:model]) {
            isExist = NO;
            break;
        }
    }
    NSString *name = model.store_name;
    if (isExist && (![self.selectedShopArray containsObject:name])) {
        [self.selectedShopArray addObject:model.store_name];
    }
    if (!isExist && ([self.selectedShopArray containsObject:name])) {
        [self.selectedShopArray removeObject:model.store_name];
    }
    if (self.selectedShopArray.count == self.shopNameArray.count) {
        //全部店铺添加
        self.bottomPriceView.isSelectBtn = YES;
    }
    
    self.bottomPriceView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
    self.bottomPriceView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
    [self.shoppingCart reloadData];

}
-(void)shoppingCartGoodsChanged:(SQShoppingCartGoodsCell*)cell withSelectedModel:(SQShoppingCartModel *)model{
    
    self.allSum = 0;
    for (SQShoppingCartModel *model in self.selectedArray) {
        self.allSum += (model.goods_price * model.goods_num);
    }
    self.bottomPriceView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
}
#pragma mark 监听方法
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        // Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y >= self.view.height) {
            self.goodsToolBar.y = self.view.height;
        } else {
            self.goodsToolBar.y = keyboardF.origin.y - self.goodsToolBar.height;
        }
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
