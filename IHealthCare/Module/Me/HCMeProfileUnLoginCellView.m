//
//  HCMeProfileUnLoginCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMeProfileUnLoginCellView.h"

@implementation HCMeProfileUnLoginCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAvtarImage];
        [self initUnloginLabel];
    }
    
    return self;
}

-(void)layoutProfileViews
{
    [m_avtarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [m_unLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_avtarImageView.mas_right).offset(30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

@end


