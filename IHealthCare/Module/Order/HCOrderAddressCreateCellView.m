//
//  HCOrderAddressCreateCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressCreateCellView.h"

@implementation HCOrderAddressCreateCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews
{
    [self initLeftTitleView];
}

-(void)initLeftTitleView
{
    m_titleLabel = [[UILabel alloc] init];
    m_titleLabel.font = [UIFont systemFontOfSize:14.0f];
    m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"0F0F0F"];
    m_titleLabel.text = self.leftTitle;
    [self addSubview:m_titleLabel];
    
    [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];
}

-(void)layoutContentViews
{
    m_titleLabel.text = self.leftTitle;
}

@end
