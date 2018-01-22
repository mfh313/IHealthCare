//
//  HCFavoritesCellView.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCFavoritesCellView.h"

@interface HCFavoritesCellView ()
{
    __weak IBOutlet UIImageView *m_imageView;
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_subTitleLabel;
}

@end

@implementation HCFavoritesCellView

-(void)setImageUrl:(NSString *)imageUrl
{
    [m_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    m_titleLabel.text = title;
    m_subTitleLabel.text = subTitle;
}

@end
