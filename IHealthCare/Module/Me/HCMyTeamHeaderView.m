//
//  HCMyTeamHeaderView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyTeamHeaderView.h"

@interface HCMyTeamHeaderView ()
{
    __weak IBOutlet UIImageView *m_imageView;
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_subTitleLabel;
    __weak IBOutlet UILabel *m_levelLabel;
}

@end

@implementation HCMyTeamHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:m_imageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = m_imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    m_imageView.layer.mask = maskLayer;
}

-(void)setImageUrl:(NSString *)imageUrl
{
    [m_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle level:(NSString *)level
{
    m_titleLabel.text = title;
    m_subTitleLabel.text = subTitle;
    m_levelLabel.text = level;
}

@end
