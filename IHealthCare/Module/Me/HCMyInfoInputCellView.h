//
//  HCMyInfoInputCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HCMyInfoInputType) {
    HCMyInfoInputType_textField = 0,
    HCMyInfoInputType_content = 1,
    HCMyInfoInputType_citySelect = 2
};

@interface HCMyInfoInputCellView : UIView <UITextFieldDelegate>
{
    UILabel *m_titleLabel;
    UILabel *m_contentLabel;
    UITextField *m_textField;
    
    CGFloat m_titleWidth;
}

-(void)setContentViewType:(HCMyInfoInputType)inputType;
-(void)setLeftTitle:(NSString *)title titleWidth:(CGFloat)titleWidth;
-(void)setShowContent:(NSString *)content;
-(void)setTextFieldContent:(NSString *)content placeHolder:(NSString *)placeHolder;
-(UITextField *)contentTextField;

@end
