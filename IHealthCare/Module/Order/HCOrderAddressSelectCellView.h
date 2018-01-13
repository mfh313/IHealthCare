//
//  HCOrderAddressSelectCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIView.h"

@interface HCOrderAddressSelectCellView : MMUIView
{
    UIImageView *m_selectImageView;
    UIView *m_addressContentView;
    UIButton *m_editButton;
}

-(void)setAddressSelected:(BOOL)selected;

@end
