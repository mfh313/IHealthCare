//
//  HCHealthManagementDetailToolBar.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCHealthManagementDetailToolBar;
@protocol HCHealthManagementDetailToolBarDelegate <NSObject>
@optional
-(void)onClickMessageButton:(HCHealthManagementDetailToolBar *)toolBar;
-(void)onClickPraiseButton:(HCHealthManagementDetailToolBar *)toolBar;
-(void)onClickWriteButton:(HCHealthManagementDetailToolBar *)toolBar;

@end

@interface HCHealthManagementDetailToolBar : MMUIBridgeView

@property (nonatomic,weak) id<HCHealthManagementDetailToolBarDelegate> m_delegate;

@end
