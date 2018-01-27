//
//  HCMyTeamCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "HCMyCustomerModel.h"

@class HCMyTeamCellView;
@protocol HCMyTeamCellViewDelegate <NSObject>
@optional

-(void)onClickUpdate:(HCMyCustomerModel *)customerModel cellView:(HCMyTeamCellView *)cellView;

@end

@interface HCMyTeamCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCMyTeamCellViewDelegate> m_delegate;

-(void)setCustomerModel:(HCMyCustomerModel *)customerModel;

@end
