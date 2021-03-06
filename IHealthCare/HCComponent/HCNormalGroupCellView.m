//
//  HCNormalGroupCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/24.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCNormalGroupCellView.h"

@interface HCNormalGroupCellView ()
{
    __weak IBOutlet UIImageView *m_leftImageView;
    
    __weak IBOutlet UILabel *m_titleLabel;
}

@end

@implementation HCNormalGroupCellView

-(void)setLeftImage:(UIImage *)leftImage
{
    m_leftImageView.image = leftImage;
}

-(void)setTitle:(NSString *)title
{
    m_titleLabel.text = title;
}

@end
