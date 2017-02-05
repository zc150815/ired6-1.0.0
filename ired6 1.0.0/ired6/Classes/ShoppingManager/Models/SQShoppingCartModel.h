//
//  SQShoppingCartModel.h
//  ired6
//
//  Created by zhangchong on 2017/2/4.
//  Copyright © 2017年 ired6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQShoppingCartModel : NSObject

@property (nonatomic, assign) NSInteger bl_id;
/**买家id*/
@property (nonatomic, assign) NSInteger buyer_id;
/**购物车id*/
@property (nonatomic, assign) NSInteger cart_id;
/**商品id*/
@property (nonatomic, assign) NSInteger goods_id;
/**商品图片链接 最后名字*/
@property (nonatomic, copy) NSString *goods_image;
/**商品图片链接*/
@property (nonatomic, copy) NSString *goods_image_url;
/**商品名称*/
@property (nonatomic, copy) NSString *goods_name;
/**商品数量*/
@property (nonatomic, assign) NSInteger goods_num;
/**商品价格*/
@property (nonatomic, assign) CGFloat goods_price;
/**商品总价格*/
@property (nonatomic, assign) CGFloat goods_sum;
/**店铺id*/
@property (nonatomic, assign) NSInteger store_id;
/**店铺名称*/
@property (nonatomic, copy) NSString *store_name;

/**上次是否被选*/
@property (nonatomic, assign) BOOL isSelect;

@end
