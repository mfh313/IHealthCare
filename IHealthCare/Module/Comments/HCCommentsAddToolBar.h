//
//  HCCommentsAddToolBar.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCCommentsAddToolBar;
@protocol HCCommentsAddToolBarDelegate <NSObject>

@optional
-(void)onClickWriteButton:(HCCommentsAddToolBar *)toolBar;

@end

@interface HCCommentsAddToolBar : MMUIBridgeView

@property (nonatomic,weak) id<HCCommentsAddToolBarDelegate> m_delegate;

@end
