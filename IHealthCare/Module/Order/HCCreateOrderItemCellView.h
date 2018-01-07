//
//  HCCreateOrderItemCellView.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCProductDetailModel;
@interface HCCreateOrderItemCellView : MMUIBridgeView

-(void)setProductDetail:(HCProductDetailModel *)detailModel;
-(void)setOrderItemCount:(NSInteger)count;

@end
