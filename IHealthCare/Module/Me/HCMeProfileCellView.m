//
//  HCMeProfileCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMeProfileCellView.h"

@implementation HCMeProfileCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hx_colorWithHexString:@"FFFFFF"];
    }
    
    return self;
}

-(void)initAvtarImage
{
    m_avtarImageView = [[UIImageView alloc] initWithImage:MFImage(@"my_img_default_head_nor")];
    [self addSubview:m_avtarImageView];
}

-(void)initUnloginLabel
{
    m_unLoginLabel = [[UILabel alloc] init];
    m_unLoginLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    m_unLoginLabel.text = @"登录注册";
    m_unLoginLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:m_unLoginLabel];
}

-(void)initNameLabel
{
    m_nameLabel = [[UILabel alloc] init];
    m_nameLabel.textColor = [UIColor hx_colorWithHexString:@"000000"];
    m_nameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:m_nameLabel];
}

-(void)initLevelLabel
{
    m_levelLabel = [[UILabel alloc] init];
    m_levelLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    m_levelLabel.text = @"级别";
    m_levelLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:m_levelLabel];
}

-(void)initAuthedLabel
{
    m_authedLabel = [[UILabel alloc] init];
    m_authedLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    m_authedLabel.text = @"已认证";
    m_authedLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:m_authedLabel];
}

-(void)initAccessoryImageView
{
    m_accessoryImageView = [[UIImageView alloc] initWithImage:MFImage(@"common_btn_next_nor")];
    [self addSubview:m_accessoryImageView];
}

-(void)layoutProfileViews
{
    
}

@end
