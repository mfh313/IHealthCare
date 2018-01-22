//
//  HCOrderListItemModel.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCProductDetailModel.h"

extern NSInteger const HCOrderList_state_1;   //未付

#pragma mark - HCOrderListOrderItemModel
@interface HCOrderListOrderItemModel : NSObject

@property (nonatomic,assign) NSInteger itemid;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) CGFloat subtotal;
@property (nonatomic,strong) HCProductDetailModel *product;


@end

#pragma mark - HCOrderListItemModel
@interface HCOrderListItemModel : NSObject

@property (nonatomic,assign) NSInteger oid;
@property (nonatomic,assign) CGFloat total;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *orderName;
@property (nonatomic,assign) NSInteger state; //1:未付 2:订单已经付款 3:已经发货 4:订单结束
@property (nonatomic,strong) NSString *orderTime;
@property (nonatomic,strong) NSMutableArray<HCOrderListOrderItemModel *> *orderItems;

@end



