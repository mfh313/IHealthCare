//
//  HCHighProductDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/21.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHighProductDetailViewController.h"
#import "HCProductDetailModel.h"
#import "HCHighProductDetailBottomView.h"

@interface HCHighProductDetailViewController () <HCHighProductDetailBottomViewDelegate>
{
    HCHighProductDetailBottomView *m_bottomView;
}

@end

@implementation HCHighProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBarButton];
    
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

#pragma mark - HCHighProductDetailBottomViewDelegate
-(void)onClickBuyProduct
{
    NSLog(@"onClickBuyProduct");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
