//
//  HCOrderListOrderInfoCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderListOrderInfoCellView.h"

@interface HCOrderListOrderInfoCellView ()
{
    __weak IBOutlet UILabel *_countLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    __weak IBOutlet UILabel *_methodLabel;
}

@end

@implementation HCOrderListOrderInfoCellView

-(void)setOrderListModel:(HCOrderListItemModel *)itemModel
{
    HCOrderListOrderItemModel *orderItem = itemModel.orderItems.firstObject;
    HCProductDetailModel *product = orderItem.product;
    
    _countLabel.text = [NSString stringWithFormat:@"共%@件商品",@(orderItem.count)];
    if (itemModel.state == HCOrderList_state_1)
    {
        _methodLabel.text = @"需付款：";
    }
    else
    {
        _methodLabel.text = @"已付款：";
    }
    
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f",orderItem.subtotal];
}

@end
