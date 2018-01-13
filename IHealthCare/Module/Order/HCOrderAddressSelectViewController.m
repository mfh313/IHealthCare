//
//  HCOrderAddressSelectViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressSelectViewController.h"
#import "HCOrderUserAddressModel.h"

@interface HCOrderAddressSelectViewController ()

@end

@implementation HCOrderAddressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址";
    [self setBackBarButton];
    
    [self setBottomView];
}

-(void)setBottomView
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];
    
    UIView *separator = [UIView new];
    separator.backgroundColor = MFCustomLineColor;
    [bottomView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom);
        make.width.equalTo(bottomView.mas_width);
        make.height.mas_equalTo(MFOnePixHeight);
    }];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButton setTitle:@"新建地址" forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [bottomButton addTarget:self action:@selector(onClickBottomButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(40);
    }];
}

-(void)onClickBottomButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
