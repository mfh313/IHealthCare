//
//  HCOrderAddressCreateDefaultSetCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressCreateDefaultSetCellView.h"

@implementation HCOrderAddressCreateDefaultSetCellView

-(void)layoutContentViews
{
    [super layoutContentViews];
    
    [m_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(110);
    }];
    
}

@end
