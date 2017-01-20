//
//  ZCKeyboard.m
//  charity
//
//  Created by zhangchong on 2016/12/29.
//  Copyright © 2016年 com.charity.huakala. All rights reserved.
//

#import "ZCKeyboard.h"

//获取设备宽度
#define DeviceW [UIScreen mainScreen].bounds.size.width
//获取设备高度
#define DeviceH [UIScreen mainScreen].bounds.size.height

static CGFloat const ItemSpacing = 2;  //每个按钮之间的      `间距
static NSString *reuseId = @"KeyboardCellID";//cell标示
//static CGFloat const Char_Size = 16; //工具条里文字的大小
#define KeyBoardHeight (0.45 * DeviceH)//整个键盘的高度
#define ToolBarViewH (0.05 * DeviceH) //工具条的高度
#define ItemW (DeviceW - 2 * ItemSpacing) / 3 //按钮的宽度
#define ItemH (self.frame.size.height-3*ItemSpacing-ToolBarViewH)/4 //按钮的高度

@interface ZCKeyboard ()<UICollectionViewDelegate,UICollectionViewDataSource>
//记录上部的工具条
@property (weak,nonatomic)UIView *toolBar;
//记录下部的键盘
@property (weak,nonatomic)UICollectionView *keyboardView;
//键盘的数据源
@property (strong,nonatomic)NSArray *titleArr;
//记录按钮服务的对象
@property (strong,nonatomic)UITextField *textField;
@end

@implementation ZCKeyboard

//初始化类方法
+ (instancetype)keyboardWithTextField:(UITextField *)textField {
    return [[self alloc] initWithTextField:textField];
}

//自定义私有的init方法
- (instancetype)initWithTextField:(UITextField *)textField {
    self = [super init];
    if (self) {
        //记录按钮服务的对象
        self.textField = textField;
        //kvo实时监听textField内容变化
        [self.textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        if (self.textFieldValueChanged) {
            self.textFieldValueChanged(change[NSKeyValueChangeNewKey]);
        }
    }
}

#pragma mark - 重写父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self prepare];
    }
    return self;
}

- (void)prepare {

    self.height = KeyBoardHeight;

    //**上部工具条toolBar区域**
    UIView *toolBar = [[UIView alloc] init];
    toolBar.backgroundColor = SQ_GlobalRBG;
    self.toolBar = toolBar;
    [self addSubview:toolBar];
    
    //toolBar里面的图片
//    UIImageView *safeImage = [[UIImageView alloc] init];
//    safeImage.image = [UIImage imageNamed:@"safe"];
//    safeImage.tag = 1001;
//    [safeImage sizeToFit];
//    [toolBar addSubview:safeImage];
    //toolBar里面的标签
//    UILabel *safeLabel = [[UILabel alloc] init];
//    safeLabel.tag = 1002;
//    safeLabel.textAlignment = NSTextAlignmentCenter;
//    safeLabel.text = @"安全键盘";
//    safeLabel.textColor = [UIColor blackColor];
//    [safeLabel sizeToFit];
//    safeLabel.font = SQ_Font(SQ_Fit(15));
//    [toolBar addSubview:safeLabel];
    
    UIButton *safeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [safeBtn setImage:[UIImage imageNamed:@"safe"] forState:UIControlStateNormal];
    [safeBtn setTitle:@"安全键盘" forState:UIControlStateNormal];
    [safeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    safeBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
    safeBtn.tag = 1001;
    [toolBar addSubview:safeBtn];
    
    //toolBar里面的完成按钮
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.tag = 1002;
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = SQ_Font(SQ_Fit(15));
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:doneBtn];
    
    //**下部的键盘区域**
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = ItemSpacing;
    flowLayout.minimumLineSpacing = ItemSpacing;
    flowLayout.sectionInset = UIEdgeInsetsMake(ItemSpacing, 0, -ItemSpacing, 0);
    
    UICollectionView *keyboardView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.keyboardView = keyboardView;
    //注册cell
    [keyboardView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseId];
    [self addSubview:keyboardView];
    
    keyboardView.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1.0];
    keyboardView.delaysContentTouches = NO;
    keyboardView.dataSource = self;
    keyboardView.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //上部布局
    self.toolBar.frame = CGRectMake(0, 0, DeviceW, ToolBarViewH);
    [self viewWithTag:1001].center = self.toolBar.center;
    [[self viewWithTag:1001] sizeToFit];
    [self viewWithTag:1002].frame = CGRectMake(DeviceW - 50 - 10, 0, 50,ToolBarViewH);
    
    //下部布局
    self.keyboardView.frame = CGRectMake(0, ToolBarViewH, DeviceW, self.frame.size.height-ToolBarViewH);
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.keyboardView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(ItemW, ItemH);
    
}


#pragma mark - 键盘事件处理
//完成按钮点击
- (void)doneBtnClick {
    [self.textField resignFirstResponder];
}
//要显示的数字处理
- (void)showInput:(UITextField *)textField numberStr:(NSString *)numStr {
    
    if ([@"10" isEqualToString:numStr]) {
        textField.text = @"";
    }else if([@"11" isEqualToString:numStr]) {
            NSString *newStr = [textField.text stringByAppendingString:@"0"];
            textField.text = newStr;
    }else if([@"12" isEqualToString:numStr]) {
        if (textField.text.length > 0) {
            NSString *newStr = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = newStr;
        }
    }else {
        NSString *newStr = [textField.text stringByAppendingString:numStr];
        textField.text = newStr;
    }
}

#pragma mark - UICollectionViewData Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    
    if (indexPath.item == 11) {
        UIImageView *deleteImg = [[UIImageView alloc] init];
        deleteImg.image = [UIImage imageNamed:@"delete"];
        deleteImg.contentMode = UIViewContentModeCenter;
        deleteImg.frame = cell.contentView.bounds;
        [cell.contentView addSubview:deleteImg];
    } else {
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.frame = cell.contentView.bounds;
        numberLabel.textColor = [UIColor blackColor];
        numberLabel.text = self.titleArr[indexPath.item];
        [cell.contentView addSubview:numberLabel];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *targetStr = [NSString stringWithFormat:@"%zd",(indexPath.item + 1)];
    [self showInput:self.textField numberStr:targetStr];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-  (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - 懒加载
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"C",@"0",@""];
    }
    return _titleArr;
}

- (void)dealloc {
    //移除观察
    [self.textField removeObserver:self forKeyPath:@"text"];
}

@end
