//
//  HealthCareCenterMenuItemView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HealthCareCenterMenuItemView.h"

@interface HealthCareCenterMenuItemView ()
{
    __weak IBOutlet UIButton *m_contentBtn;
    __weak IBOutlet UILabel *m_contentLabel;
}

@end

@implementation HealthCareCenterMenuItemView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [m_contentBtn addTarget:self action:@selector(onClickContentButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutMenuView
{
    NSString *normalTitle = @"查报告";
    if ([self.m_dataSource respondsToSelector:@selector(menuTitleItemView:index:)]) {
        normalTitle = [self.m_dataSource menuTitleItemView:self index:self.index];
    }
    m_contentLabel.text = normalTitle;
    
    NSString *normalImage = @"common_btn_report_nor";
    NSString *highlightedImage = @"common_btn_report_nor";
    if ([self.m_dataSource respondsToSelector:@selector(normalImageItemView:index:)]) {
        normalImage = [self.m_dataSource normalImageItemView:self index:self.index];
    }
    
    if ([self.m_dataSource respondsToSelector:@selector(highlightedImageItemView:index:)]) {
        highlightedImage = [self.m_dataSource highlightedImageItemView:self index:self.index];
    }
    [m_contentBtn setImage:MFImage(normalImage) forState:UIControlStateNormal];
    [m_contentBtn setImage:MFImage(highlightedImage) forState:UIControlStateHighlighted];
}

-(void)onClickContentButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickMenuItemView:index:)]) {
        [self.m_delegate onClickMenuItemView:self index:self.index];
    }
}

@end
