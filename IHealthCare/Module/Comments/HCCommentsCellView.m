//
//  HCCommentsCellView.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCommentsCellView.h"

@interface HCCommentsCellView ()
{
    __weak IBOutlet UIImageView *m_avtarImageView;
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_timeLabel;
    __weak IBOutlet UILabel *m_contentLabel;
    
}

@end

@implementation HCCommentsCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_avtarImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:m_avtarImageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = m_avtarImageView.bounds;
    maskLayer.path = maskPath.CGPath;
    m_avtarImageView.layer.mask = maskLayer;
}

-(void)setCommentsDetailModel:(HCCommentsDetailModel *)detail
{
    [m_avtarImageView sd_setImageWithURL:[NSURL URLWithString:detail.user.imageUrl]];
    m_nameLabel.text = detail.user.name;
    m_timeLabel.text = detail.createTime;
    m_contentLabel.text = detail.content;
}

@end
