//
//  HCOrderListOrderBottomCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderListOrderBottomCellView.h"

@interface HCOrderListOrderBottomCellView ()
{
    __weak IBOutlet UIButton *m_payButton;
}

@end

@implementation HCOrderListOrderBottomCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_payButton setTitle:@"去支付" forState:UIControlStateNormal];
    [m_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [m_payButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [m_payButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [m_payButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
}

- (IBAction)onClickToPay:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickToPayOrderList:)]) {
        [self.m_delegate onClickToPayOrderList:self.attachIndex];
    }
}

@end
