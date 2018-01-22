//
//  HCOrderListViewController.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderListViewController.h"
#import "HCOrderListOrderCellView.h"
#import "HCOrderListOrderInfoCellView.h"
#import "HCOrderListOrderBottomCellView.h"
#import "HCGetOrdersApi.h"

@interface HCOrderListViewController ()
{
    
}

@end

@implementation HCOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    [self setBackBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
