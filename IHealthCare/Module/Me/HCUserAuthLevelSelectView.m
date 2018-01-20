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
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        m_BigCustomerView = [[HCUserAuthLevelSelectItemView alloc] init];
        m_BigCustomerView.attchValue = HCUserLevel_3;
        [m_BigCustomerView setItemTitle:@"大客户"];
        [self addSubview:m_BigCustomerView];
        
        [m_BigCustomerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(m_titleLabel.mas_right).offset(20);
            make.width.mas_equalTo(@(90));
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        m_AgentView = [[HCUserAuthLevelSelectItemView alloc] init];
        m_AgentView.attchValue = HCUserLevel_4;
        [m_AgentView setItemTitle:@"代理商"];
        [self addSubview:m_AgentView];
        
        [m_AgentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(m_BigCustomerView.mas_right).offset(0);
            make.width.mas_equalTo(@(90));
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_BigCustomerView addTarget:self action:@selector(onClickLevelSelectItemView:) forControlEvents:UIControlEventTouchUpInside];
        [m_AgentView addTarget:self action:@selector(onClickLevelSelectItemView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)onClickLevelSelectItemView:(HCUserAuthLevelSelectItemView *)itemView
{
    NSInteger attchValue = itemView.attchValue;
    [self setCurrentLevel:attchValue];
}

-(void)setCurrentLevel:(NSInteger)level
{
    if (level == HCUserLevel_3)
    {
        [m_BigCustomerView setSelected:YES];
        [m_AgentView setSelected:NO];
    }
    else if (level == HCUserLevel_4)
    {
        [m_BigCustomerView setSelected:NO];
        [m_AgentView setSelected:YES];
    }
}

@end
