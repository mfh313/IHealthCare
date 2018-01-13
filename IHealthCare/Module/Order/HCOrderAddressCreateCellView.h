//
//  HCOrderAddressCreateCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIView.h"

@class HCOrderAddressCreateCellView;
@protocol HCOrderAddressCreateCellViewDelegate <NSObject>
@optional
-(BOOL)orderAddressCreateCellView:(HCOrderAddressCreateCellView *)cellView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(void)orderAddressTextFiledEditChanged:(HCOrderAddressCreateCellView *)cellView;
-(void)onClickSelectCity:(HCOrderAddressCreateCellView *)cellView;

@end

@interface HCOrderAddressCreateCellView : MMUIView
{
    UILabel *m_titleLabel;
    UITextField *m_textField;
    UILabel *m_contentLabel;
    UIImageView *m_accessoryView;
}

@property (nonatomic,strong) NSString *attachKey;
@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,weak) id<HCOrderAddressCreateCellViewDelegate> m_delegate;

-(void)initSubViews;
-(void)initLeftTitleView;
-(void)initTextField;
-(void)initContentLabel;
-(void)layoutContentViews;
-(UITextField *)contentTextField;
-(void)setTextFieldValue:(NSString *)text;
-(void)initAccessoryView;
-(void)setContentLabelValue:(NSString *)text;

@end
