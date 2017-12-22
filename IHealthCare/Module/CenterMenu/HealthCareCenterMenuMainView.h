//
//  HealthCareCenterMenuMainView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HealthCareCenterMenuMainView;
@protocol HealthCareCenterMenuMainViewDelegate <NSObject>
@optional

-(void)onClickMenu:(HealthCareCenterMenuMainView *)menuView actionKey:(NSString *)key;
-(void)onClickCloseButton:(HealthCareCenterMenuMainView *)menuView;
-(void)onClickShowMyInfo:(HealthCareCenterMenuMainView *)menuView;

@end

@interface HealthCareCenterMenuMainView : MMUIBridgeView

@property (nonatomic,weak) id<HealthCareCenterMenuMainViewDelegate> m_delegate;

@end
