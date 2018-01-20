//
//  HCUserAuthTextInputCellView.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCUserAuthTextInputCellView;
@protocol HCUserAuthTextInputCellViewDelegate <NSObject>
@optional
-(BOOL)userAuthTextInputCellView:(HCUserAuthTextInputCellView *)cellView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(void)userAuthTextFieldEditChanged:(HCUserAuthTextInputCellView *)cellView;

@end

@interface HCUserAuthTextInputCellView : UIView <UITextFieldDelegate>
{
    UITextField *m_textField;
}

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,weak) id<HCUserAuthTextInputCellViewDelegate> m_delegate;

-(UITextField *)contentTextField;
-(void)setPlaceHolder:(NSString *)placeHolder;

@end
