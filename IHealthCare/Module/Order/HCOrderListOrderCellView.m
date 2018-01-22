//
//  HCOrderListOrderCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderListOrderCellView.h"

@interface HCOrderListOrderCellView ()
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_salesLabel;
    __weak IBOutlet UILabel *_promotionLabel;
    
}

@end

@implementation HCOrderListOrderCellView

-(void)setOrderListModel:(HCOrderListItemModel *)itemModel
{
    HCOrderListOrderItemModel *orderItem = itemModel.orderItems.firstObject;
    HCProductDetailModel *product = orderItem.product;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:product.image]];
    _nameLabel.text = product.pname;
    _salesLabel.text = [NSString stringWithFormat:@"销量：%@",@(product.sales)];
    _promotionLabel.text = [NSString stringWithFormat:@"推广：%@",@(product.promotionFee)];
}

@end

