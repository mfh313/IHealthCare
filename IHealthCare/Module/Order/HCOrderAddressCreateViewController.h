//
//  HCOrderAddressCreateViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@class HCOrderAddressCreateViewController;
@protocol HCOrderAddressCreateViewControllerDelegate <NSObject>
@optional
-(void)onCreateAddress:(HCOrderAddressCreateViewController *)controller addressInfo:(NSMutableDictionary *)info;

@end

@interface HCOrderAddressCreateViewController : MMUIViewController

@property (nonatomic,weak) id<HCOrderAddressCreateViewControllerDelegate> m_delegate;

@end
