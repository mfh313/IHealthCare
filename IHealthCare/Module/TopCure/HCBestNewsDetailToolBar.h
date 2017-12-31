//
//  HCBestNewsDetailToolBar.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/31.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCBestNewsDetailToolBar;
@protocol HCBestNewsDetailToolBarDelegate <NSObject>
@optional
-(void)onClickMessageButton:(HCBestNewsDetailToolBar *)toolBar;
-(void)onClickPraiseButton:(HCBestNewsDetailToolBar *)toolBar;
-(void)onClickCollectionButton:(HCBestNewsDetailToolBar *)toolBar;
-(void)onClickWriteButton:(HCBestNewsDetailToolBar *)toolBar;

@end

@interface HCBestNewsDetailToolBar : MMUIBridgeView

@property (nonatomic,weak) id<HCBestNewsDetailToolBarDelegate> m_delegate;

@end
