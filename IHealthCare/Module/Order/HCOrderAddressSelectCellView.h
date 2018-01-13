//
//  HCOrderAddressSelectCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIView.h"

@protocol HCOrderAddressSelectCellViewDelegate <NSObject>
@optional


@end

@interface HCOrderAddressSelectCellView : MMUIView
{
    UIImageView *m_selectImageView;
    
    UILabel *m_nameLabel;
    UILabel *m_phoneLabel;
    UILabel *m_addressLabel;
    UIView *m_addressContentView;
    
    UIButton *m_editButton;
}

@property (nonatomic,weak) id<HCOrderAddressSelectCellViewDelegate> m_delegate;

-(void)setAddressSelected:(BOOL)selected;
-(void)setAddressInfo:(NSString *)name phone:(NSString *)phone address:(NSString *)address;

@end
