//
//  HCOrderAddressCreateRegionCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressCreateRegionCellView.h"

@implementation HCOrderAddressCreateRegionCellView

-(void)initSubViews
{
    [super initSubViews];
    
    [self initAccessoryView];
    [self initContentLabel];
}

-(void)layoutContentViews
{
    [super layoutContentViews];
    
    [m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_titleLabel.mas_right).offset(10);
        make.right.mas_equalTo(m_accessoryView.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.mas_height);
    }];
}

@end

