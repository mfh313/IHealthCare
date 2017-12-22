//
//  HealthCareTabBarController.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMTabBarController.h"

@class HealthCareTabBarController;
@protocol HealthCareTabBarControllerDelegate <NSObject>
@optional
-(void)onClickTabBarCenterMenuView:(HealthCareTabBarController *)tabBarController;

@end

@interface HealthCareTabBarController : MMTabBarController

@property (nonatomic,weak) id<HealthCareTabBarControllerDelegate> m_delegate;

@end
