//
//  HCMyInfoAvtarCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyInfoAvtarCellView.h"

@interface HCMyInfoAvtarCellView ()
{
    __weak IBOutlet UIImageView *m_avtarImageView;
}

@end

@implementation HCMyInfoAvtarCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_avtarImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:m_avtarImageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = m_avtarImageView.bounds;
    maskLayer.path = maskPath.CGPath;
    m_avtarImageView.layer.mask = maskLayer;
}

-(void)setAvtarImageUrl:(NSString *)url
{
    [m_avtarImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:MFImage(@"my_img_default_head_nor")];
}

@end
