//
//  HCHealthMedicalServiceCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCMedicalServiceDetailModel;
@protocol HCHealthMedicalServiceCellViewDelegate <NSObject>
@optional
-(void)onClickShowMedicalService:(HCMedicalServiceDetailModel *)itemModel;

@end

@interface HCHealthMedicalServiceCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCHealthMedicalServiceCellViewDelegate> m_delegate;

-(void)setMedicalService:(HCMedicalServiceDetailModel *)itemModel;

@end
