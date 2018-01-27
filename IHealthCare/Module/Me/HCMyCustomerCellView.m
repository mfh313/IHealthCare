//
//  HCMyCustomerCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyCustomerCellView.h"

@interface HCMyCustomerCellView ()
{
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_countLabel;
    __weak IBOutlet UILabel *m_levelLabel;
}

@end

@implementation HCMyCustomerCellView

-(void)setName:(NSString *)name No:(NSString *)NoStr level:(NSString *)level
{
    m_nameLabel.text = name;
    m_countLabel.text = NoStr;
    m_levelLabel.text = level;
}


@end
