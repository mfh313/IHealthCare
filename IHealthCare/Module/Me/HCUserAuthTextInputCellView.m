//
//  HCUserAuthTextInputCellView.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthTextInputCellView.h"

@implementation HCUserAuthTextInputCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_textField = [[UITextField alloc] init];
        m_textField.delegate = self;
        m_textField.backgroundColor = [UIColor whiteColor];
        m_textField.textColor = [UIColor hx_colorWithHexString:@"000000"];
        m_textField.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:m_textField];
        
        [m_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(40);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:m_textField];
    }
    
    return self;
}

-(UITextField *)contentTextField
{
    return m_textField;
}

-(void)setPlaceHolder:(NSString *)placeHolder
{
    m_textField.placeholder = placeHolder;
}

- (void)textFiledEditChanged:(NSNotification *)notifi
{
    UITextField *textField = (UITextField *)notifi.object;
    NSString *text = textField.text;
    if ([self.m_delegate respondsToSelector:@selector(userAuthTextFieldEditChanged:)]) {
        [self.m_delegate userAuthTextFieldEditChanged:self];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.m_delegate respondsToSelector:@selector(userAuthTextInputCellView:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.m_delegate userAuthTextInputCellView:self shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

@end
