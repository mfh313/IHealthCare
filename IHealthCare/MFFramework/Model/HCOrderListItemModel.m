//
//  HCOrderListItemModel.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderListItemModel.h"

NSInteger const HCOrderList_state_1 = 1;   //未付

#pragma mark - HCOrderListOrderItemModel
@implementation HCOrderListOrderItemModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"product" : [HCProductDetailModel class]};
}

@end

#pragma mark - HCOrderListItemModel
@implementation HCOrderListItemModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderItems" : [HCOrderListOrderItemModel class]};
}

@end
