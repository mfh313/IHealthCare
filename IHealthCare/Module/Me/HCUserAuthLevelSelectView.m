//
//  HCUserAuthLevelSelectView.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthLevelSelectView.h"

@implementation HCUserAuthLevelSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"CECECE"];
        m_titleLabel.font = [UIFont systemFontOfSize:16.0f];
        m_titleLabel.text = @"身份选择";
        [self addSubview:m_titleLabel];
        
        [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(40);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    
    return self;
}

-(void)setCurrentLevel:(NSInteger)level
{
    
}

@end
