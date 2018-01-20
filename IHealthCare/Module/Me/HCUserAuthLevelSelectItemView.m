//
//  HCUserAuthLevelSelectItemView.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthLevelSelectItemView.h"

@implementation HCUserAuthLevelSelectItemView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_imageView = [[UIImageView alloc] initWithImage:MFImage(@"Rectangle 27 Copy")];
        [self addSubview:m_imageView];
        [m_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.width.mas_equalTo(@(15));
            make.height.mas_equalTo(@(15));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"CECECE"];
        m_titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:m_titleLabel];
        
        [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(m_imageView.mas_right).offset(10);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    
    return self;
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        m_imageView.image = MFImage(@"Rectangle 27");
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"000000"];
    }
    else
    {
        m_imageView.image = MFImage(@"Rectangle 27 Copy");
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"CECECE"];
    }
}

-(void)setItemTitle:(NSString *)title
{
    m_titleLabel.text = title;
}

@end
