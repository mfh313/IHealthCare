//
//  HCHighProductDetailBottomView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol HCHighProductDetailBottomViewDelegate <NSObject>
@optional
-(void)onClickBuyProduct;

@end

@interface HCHighProductDetailBottomView : MMUIBridgeView

@property (nonatomic,weak) id<HCHighProductDetailBottomViewDelegate> m_delegate;

@end
