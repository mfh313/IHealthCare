//
//  HCHealthManagementClassRoomCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCClassRoomDetailModel;
@protocol HCHealthManagementClassRoomCellViewDelegate <NSObject>
@optional
-(void)onClickClassRoomDetail:(HCClassRoomDetailModel *)itemModel;

@end

@interface HCHealthManagementClassRoomCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCHealthManagementClassRoomCellViewDelegate> m_delegate;

-(void)setClassRoomDetail:(HCClassRoomDetailModel *)itemModel;

@end
