//
//  HCUserRegisterHeaderView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/2.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCUserRegisterHeaderView;
@protocol HCUserRegisterHeaderViewDelegate <NSObject>
@optional
-(void)onClickHeadAvatarButton:(HCUserRegisterHeaderView *)view;

@end

@interface HCUserRegisterHeaderView : MMUIBridgeView

@property (nonatomic,weak) id<HCUserRegisterHeaderViewDelegate> m_delegate;

-(void)setAvatarImage:(UIImage *)image;

@end
