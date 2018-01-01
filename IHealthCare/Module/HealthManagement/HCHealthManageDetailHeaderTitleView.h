//
//  HCHealthManageDetailHeaderTitleView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCManagementDetailModel;
@protocol HCHealthManageDetailHeaderTitleViewDelegate <NSObject>
@optional
-(void)onClickChat:(HCManagementDetailModel *)itemModel;
-(void)onClickFollowUp:(HCManagementDetailModel *)itemModel;

@end

@class HCManagementDetailModel;
@interface HCHealthManageDetailHeaderTitleView : MMUIBridgeView

@property (nonatomic,weak) id<HCHealthManageDetailHeaderTitleViewDelegate> m_delegate;

-(void)setManagementDetail:(HCManagementDetailModel *)itemModel;

@end
