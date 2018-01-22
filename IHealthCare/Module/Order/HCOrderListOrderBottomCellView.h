//
//  HCOrderListOrderBottomCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol HCOrderListOrderBottomCellViewDelegate <NSObject>
@optional
-(void)onClickToPayOrderList:(NSInteger)attachIndex;

@end

@interface HCOrderListOrderBottomCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCOrderListOrderBottomCellViewDelegate> m_delegate;
@property (nonatomic,assign) NSInteger attachIndex;

@end
