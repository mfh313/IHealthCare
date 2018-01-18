//
//  HCMyInfoInputCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCMyInfoInputCellView : UIView <UITextFieldDelegate>
{
    UILabel *m_titleLabel;
    UILabel *m_contentLabel;
    UITextField *m_textField;
    
    CGFloat m_titleWidth;
}

-(void)setLeftTitle:(NSString *)title titleWidth:(CGFloat)titleWidth;
-(UITextField *)contentTextField;
-(void)setShowContent:(NSString *)content;
-(void)setTextFieldContent:(NSString *)content placeHolder:(NSString *)placeHolder;

@end
