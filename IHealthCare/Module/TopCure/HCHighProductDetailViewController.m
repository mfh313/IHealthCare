//
//  HCHighProductDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/21.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHighProductDetailViewController.h"
#import "HCProductDetailModel.h"
#import "HCHighProductDetailCustomNavbar.h"
#import "HCHighProductDetailBottomView.h"

@interface HCHighProductDetailViewController () <HCHighProductDetailCustomNavbarDelegate,HCHighProductDetailBottomViewDelegate>
{
    HCHighProductDetailCustomNavbar *m_navBar;
    HCHighProductDetailBottomView *m_bottomView;
}

@end

@implementation HCHighProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_navBar = [HCHighProductDetailCustomNavbar nibView];
    m_navBar.m_delegate = self;
    [self.view addSubview:m_navBar];
    [m_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@(44));
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view);
    }];
    
    m_bottomView = [HCHighProductDetailBottomView nibView];
    m_bottomView.m_delegate = self;
    [self.view addSubview:m_bottomView];
    [m_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - HCHighProductDetailCustomNavbarDelegate
-(void)onClickBackButton:(HCHighProductDetailCustomNavbar *)navBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onClickForwordButton:(HCHighProductDetailCustomNavbar *)navBar
{
    
}

#pragma mark - HCHighProductDetailBottomViewDelegate
-(void)onClickBuyProduct
{
    NSLog(@"onClickBuyProduct");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
