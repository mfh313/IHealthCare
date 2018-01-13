//
//  HCOrderAddressCreateViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressCreateViewController.h"
#import "HCOrderAddressCreateTextCellView.h"
#import "HCOrderAddressCreateRegionCellView.h"
#import "HCOrderAddressCreateDefaultSetCellView.h"

@interface HCOrderAddressCreateViewController ()

@end

@implementation HCOrderAddressCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建收货地址";
    [self setBackBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
