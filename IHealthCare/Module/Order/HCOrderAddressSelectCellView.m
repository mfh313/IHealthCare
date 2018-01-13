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
    m_selectImageView = [[UIImageView alloc] initWithImage:MFImage(@"home_icon_selected_nor")];
    m_selectImageView.frame = CGRectMake(15, 0, 22, 22);
    [self addSubview:m_selectImageView];
    
    [m_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(2);
    }];
}

-(void)setAddressSelected:(BOOL)selected
{
    
}

@end
