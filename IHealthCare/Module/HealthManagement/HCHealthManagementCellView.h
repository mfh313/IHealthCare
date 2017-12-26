//
//  HCHealthManagementCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/26.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCManagementDetailModel;
@protocol HCHealthManagementCellViewDelegate <NSObject>
@optional
-(void)onClickShowManagementDetail:(HCManagementDetailModel *)itemModel;

@end

@interface HCHealthManagementCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCHealthManagementCellViewDelegate> m_delegate;

-(void)setManagementDetail:(HCManagementDetailModel *)itemModel;

@end
