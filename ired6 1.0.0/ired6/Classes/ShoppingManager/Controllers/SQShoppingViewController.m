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

@property (nonatomic, strong) NSArray *dataArr;//列表数据
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
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
        
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
    self.bottomPriceView.isSelectBtn = NO;

    [[SQNetworkingTools sharedNetWorkingTools]getShoppingCartDataWithCallBack:^(id response, NSError *error) {
        
        if (error) {
            [[SQPublicTools sharedPublicTools]showMessage:@"数据获取错误" duration:3];
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
    shoppingCart.bounces = NO;
    //shoppingCart.separatorStyle = UITableViewCellSeparatorStyleNone;
    shoppingCart.showsVerticalScrollIndicator = NO;
    shoppingCart.showsHorizontalScrollIndicator = NO;
    [shoppingCart registerClass:[SQShoppingCartShopCell class] forCellReuseIdentifier:@"ShopCellID"];
    [shoppingCart registerClass:[SQShoppingCartGoodsCell class] forCellReuseIdentifier:@"GoodsCellID"];
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
    
    if (self.shopNameArray.count) {
        _bottomPriceView.hidden = NO;
        return self.shopNameArray.count;
    }else{
        _bottomPriceView.hidden = YES;
        [tableView setContentInset:UIEdgeInsetsZero];
        return 1;
    }
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
        cell.textLabel.text = @"空空如也/网络异常";
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.shopNameArray.count) {
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 100;
        }
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

@end
