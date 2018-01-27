//
//  HCNormalGroupTitleCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCNormalGroupTitleCellView.h"

@interface HCNormalGroupTitleCellView ()
{
    __weak IBOutlet UILabel *m_titleLabel;
}

@end

@implementation HCNormalGroupTitleCellView

-(void)setTitle:(NSString *)title
{
    m_titleLabel.text = title;
}

@end
