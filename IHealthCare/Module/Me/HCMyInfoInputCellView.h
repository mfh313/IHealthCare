//
//  HCMyInfoInputCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCMyInfoInputCellView;
@protocol HCMyInfoInputCellViewDelegate <NSObject>
@optional
-(BOOL)inputCellView:(HCMyInfoInputCellView *)cellView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(void)inputCellViewEditChanged:(HCMyInfoInputCellView *)cellView;

@end

@interface HCMyInfoInputCellView : UIView <UITextFieldDelegate>
{
    UILabel *m_titleLabel;
    UILabel *m_contentLabel;
    UITextField *m_textField;
    
    CGFloat m_titleWidth;
}

@property (nonatomic,weak) id<HCMyInfoInputCellViewDelegate> m_delegate;
@property (nonatomic,strong) NSString *contentKey;

-(void)setLeftTitle:(NSString *)title titleWidth:(CGFloat)titleWidth;
-(void)setShowContent:(NSString *)content;
-(void)setTextFieldContent:(NSString *)content placeHolder:(NSString *)placeHolder;
-(UITextField *)contentTextField;

@end
