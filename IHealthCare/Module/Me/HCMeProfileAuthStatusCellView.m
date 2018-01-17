//
//  HCMeProfileAuthStatusCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMeProfileAuthStatusCellView.h"

@implementation HCMeProfileAuthStatusCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAvtarImage];
        [self initNameLabel];
        [self initLevelLabel];
        
        [self initAuthedLabel];
        [self initAccessoryImageView];
    }
    
    return self;
}

-(void)layoutProfileViews
{
    m_nameLabel.text = self.userInfo.name;
    m_levelLabel.text = [self.userInfo userLevelDescription];

    [self makeSubViewsConstraints];
}

-(void)makeSubViewsConstraints
{
    [m_avtarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    
    [m_accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
}

@end
