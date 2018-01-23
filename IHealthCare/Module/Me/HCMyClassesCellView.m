//
//  HCMyClassesCellView.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyClassesCellView.h"

@interface HCMyClassesCellView ()
{
    __weak IBOutlet UIImageView *m_imageView;
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_subTitleLabel;
}

@end

@implementation HCMyClassesCellView

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
