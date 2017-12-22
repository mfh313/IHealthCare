//
//  HCHighProductCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCProductDetailModel;
@protocol HCHighProductCellViewDelegate <NSObject>
@optional
-(void)onClickShowProductDetail:(HCProductDetailModel *)itemModel;

@end

@interface HCHighProductCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCHighProductCellViewDelegate> m_delegate;

-(void)setProductDetail:(HCProductDetailModel *)itemModel;

@end
