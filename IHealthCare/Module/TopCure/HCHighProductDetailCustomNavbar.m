//
//  HCHighProductDetailCustomNavbar.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHighProductDetailCustomNavbar.h"

@implementation HCHighProductDetailCustomNavbar

- (IBAction)onClickBackButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickBackButton:)]) {
        [self.m_delegate onClickBackButton:self];
    }
}

- (IBAction)onClickForwordButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickForwordButton:)]) {
        [self.m_delegate onClickForwordButton:self];
    }
}

@end
