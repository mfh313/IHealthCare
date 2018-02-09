//
//  HCMyTeamCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyTeamCellView.h"
#import "HCUserHelper.h"

@interface HCMyTeamCellView ()
{
    __weak IBOutlet UIImageView *m_imageView;
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_NoLabel;
    __weak IBOutlet UILabel *m_levelLabel;
    __weak IBOutlet UIButton *m_updateButton;
    
    HCMyCustomerModel *m_customer;
}

@end

@implementation HCMyTeamCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:m_imageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = m_imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    m_imageView.layer.mask = maskLayer;
    
    [m_updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [m_updateButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_nor") forState:UIControlStateNormal];
    [m_updateButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_press") forState:UIControlStateHighlighted];
    [m_updateButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_dis") forState:UIControlStateDisabled];
    [m_updateButton addTarget:self action:@selector(onClickContentButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setCustomerModel:(HCMyCustomerModel *)customerModel
{
    m_customer = customerModel;
    
    [m_imageView sd_setImageWithURL:[NSURL URLWithString:m_customer.imageUrl]];
    m_nameLabel.text = m_customer.name;
    m_NoLabel.text = [NSString stringWithFormat:@"%@",@(m_customer.workId)];
    m_levelLabel.text = [HCUserHelper userLevelDescription:m_customer.level];
    
    [m_updateButton setEnabled:YES];
    
    NSInteger status = m_customer.status;
    if (m_customer.level == 6)
    {
        [m_updateButton setHidden:YES];
        
        [m_updateButton setEnabled:NO];
        [m_updateButton setTitle:@"升级" forState:UIControlStateNormal];
        
    }
    else
    {
        [m_updateButton setHidden:NO];
        
        if (m_customer.status == 0)
        {
            [m_updateButton setEnabled:YES];
            [m_updateButton setTitle:@"升级" forState:UIControlStateNormal];
        }
        else if (m_customer.status == 1)
        {
            [m_updateButton setEnabled:NO];
            [m_updateButton setTitle:@"升级中" forState:UIControlStateNormal];
        }
    }
}

-(void)onClickContentButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickUpdate:cellView:)]) {
        [self.m_delegate onClickUpdate:m_customer cellView:self];
    }
}

@end
