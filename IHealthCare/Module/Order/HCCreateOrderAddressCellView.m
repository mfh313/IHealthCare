//
//  HCCreateOrderAddressCellView.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCreateOrderAddressCellView.h"

@interface HCCreateOrderAddressCellView ()
{
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_phoneLabel;
    __weak IBOutlet UILabel *m_addressLabel;
}

@end

@implementation HCCreateOrderAddressCellView

-(void)setName:(NSString *)name
{
    m_nameLabel.text = name;
}

-(void)setPhone:(NSString *)phone
{
    m_phoneLabel.text = phone;
}

-(void)setAddressString:(NSString *)address
{
    m_addressLabel.text = address;
}

@end
