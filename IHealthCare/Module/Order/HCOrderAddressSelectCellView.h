//
//  HCOrderAddressSelectCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIView.h"
#import "HCOrderUserAddressModel.h"

@protocol HCOrderAddressSelectCellViewDelegate <NSObject>
@optional
-(void)onClickModifyAddress:(HCOrderUserAddressModel *)address;

@end

@interface HCOrderAddressSelectCellView : MMUIView
{
    UIImageView *m_selectImageView;
    
    UILabel *m_nameLabel;
    UILabel *m_phoneLabel;
    UILabel *m_addressLabel;
    UIView *m_addressContentView;
    
    UIButton *m_editButton;
    
    HCOrderUserAddressModel *m_addressInfo;
}

@property (nonatomic,weak) id<HCOrderAddressSelectCellViewDelegate> m_delegate;

-(void)setAddressInfo:(HCOrderUserAddressModel *)addressInfo;
-(void)setAddressSelected:(BOOL)selected;

@end
