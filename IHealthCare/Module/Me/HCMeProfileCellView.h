//
//  HCMeProfileCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCMeProfileCellView;
@protocol HCMeProfileCellViewDelegate <NSObject>
@optional
-(void)onClickToAuth:(HCMeProfileCellView *)view;
-(void)onClickProfileCell:(HCMeProfileCellView *)view;

@end

@interface HCMeProfileCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCMeProfileCellViewDelegate> m_delegate;

@end
