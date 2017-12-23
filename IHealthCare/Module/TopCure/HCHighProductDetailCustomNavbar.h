//
//  HCHighProductDetailCustomNavbar.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCHighProductDetailCustomNavbar;
@protocol HCHighProductDetailCustomNavbarDelegate <NSObject>
@optional
-(void)onClickBackButton:(HCHighProductDetailCustomNavbar *)navBar;
-(void)onClickForwordButton:(HCHighProductDetailCustomNavbar *)navBar;

@end

@interface HCHighProductDetailCustomNavbar : MMUIBridgeView

@property (nonatomic,weak) id<HCHighProductDetailCustomNavbarDelegate> m_delegate;

@end
