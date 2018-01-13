//
//  HCOrderAddressSelectCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressSelectCellView.h"

@implementation HCOrderAddressSelectCellView

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
    [self initSelectImageView];
    [self initAddressContentView];
    [self initEditButton];
}

-(void)initSelectImageView
{
    m_selectImageView = [[UIImageView alloc] initWithImage:MFImage(@"home_icon_selected_nor")];
    m_selectImageView.frame = CGRectMake(15, 0, 22, 22);
    [self addSubview:m_selectImageView];
    
    [m_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
}

-(void)setAddressSelected:(BOOL)selected
{
    if (selected)
    {
        [m_selectImageView setHidden:NO];
        m_nameLabel.textColor = [UIColor hx_colorWithHexString:@"FF3636"];
        m_phoneLabel.textColor = [UIColor hx_colorWithHexString:@"FF3636"];
    }
    else
    {
        [m_selectImageView setHidden:YES];
        
        m_nameLabel.textColor = [UIColor hx_colorWithHexString:@"000000"];
        m_phoneLabel.textColor = [UIColor hx_colorWithHexString:@"000000"];
    }
}

-(void)setAddressInfo:(NSString *)name phone:(NSString *)phone address:(NSString *)address
{
    m_nameLabel.text = name;
    m_phoneLabel.text = phone;
    m_addressLabel.text = address;
}

-(void)initAddressContentView
{
    m_addressContentView = [[UIView alloc] init];
    m_addressContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:m_addressContentView];
    
    [m_addressContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_selectImageView.mas_right).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-60);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.mas_height);
    }];
    
    m_nameLabel = [[UILabel alloc] init];
    m_nameLabel.font = [UIFont systemFontOfSize:14.0f];
    m_nameLabel.textColor = [UIColor hx_colorWithHexString:@"000000"];
    [m_addressContentView addSubview:m_nameLabel];
    
    m_phoneLabel = [[UILabel alloc] init];
    m_phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    m_phoneLabel.textColor = [UIColor hx_colorWithHexString:@"000000"];
    [m_addressContentView addSubview:m_phoneLabel];
    
    m_addressLabel = [[UILabel alloc] init];
    m_addressLabel.font = [UIFont systemFontOfSize:12.0f];
    m_addressLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    [m_addressContentView addSubview:m_addressLabel];
    
    [m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_addressContentView.mas_left);
        make.top.mas_equalTo(15);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(20);
    }];
    
    [m_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_nameLabel.mas_right).offset(30);
        make.centerY.mas_equalTo(m_nameLabel.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(20);
    }];
    
    [m_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_addressContentView.mas_left);
        make.top.mas_equalTo(m_nameLabel.mas_bottom).offset(13);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)initEditButton
{
    m_editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    m_editButton.backgroundColor = [UIColor whiteColor];
    [m_editButton setImage:MFImage(@"home_btn_editor_nor") forState:UIControlStateNormal];
    [self addSubview:m_editButton];
    
    [m_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(self.mas_height);
    }];
    
}

@end
