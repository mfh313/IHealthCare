//
//  HCProductDetailModel.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/16.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCClassRoomDetailModel.h"

@interface HCProductDetailModel : NSObject

@property (nonatomic,assign) NSInteger pid;  //产品id
@property (nonatomic,strong) NSString *pname; //产品名称
@property (nonatomic,strong) NSString *image; //图片
@property (nonatomic,strong) NSString *pdesc; //简介
@property (nonatomic,strong) NSString *detail; //详情
@property (nonatomic,assign) NSInteger stock;  //库存量
@property (nonatomic,assign) CGFloat marketPrice;  //市场价格
@property (nonatomic,assign) CGFloat shopPrice;    //店内价格
@property (nonatomic,assign) NSInteger isHot;  //是否热卖
@property (nonatomic,assign) CGFloat discount;    //折扣
@property (nonatomic,assign) CGFloat promotionFee;    //推广费
@property (nonatomic,strong) NSString *privilegeTime; //优惠时间
@property (nonatomic,assign) NSInteger sales;  //销量
@property (nonatomic,assign) NSInteger isInSale;  //是否销售中
@property (nonatomic,strong) NSString *creatTime;
@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,assign) NSInteger csid;

@end

#pragma mark - HCOrderItemModel
@interface HCOrderItemModel : NSObject

@property (nonatomic,assign) NSInteger pid;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) HCProductDetailModel *detailModel;
@property (nonatomic,strong) HCClassRoomDetailModel *classDetailModel;

@end
