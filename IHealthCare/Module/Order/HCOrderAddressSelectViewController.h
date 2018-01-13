//
//  HCOrderAddressSelectViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@class HCOrderUserAddressModel;
@protocol HCOrderAddressSelectViewControllerDelegate <NSObject>
@optional
-(void)onDidSelecAddress:(HCOrderUserAddressModel *)address;

@end

@interface HCOrderAddressSelectViewController : MMUIViewController

@property (nonatomic,weak) id<HCOrderAddressSelectViewControllerDelegate> m_delegate;

@end
