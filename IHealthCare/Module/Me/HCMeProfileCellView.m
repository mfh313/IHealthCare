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

-(void)layoutProfileViews
{
    
}

@end
