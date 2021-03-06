//
//  HCMyInfoInputCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyInfoInputCellView.h"

@implementation HCMyInfoInputCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.font = [UIFont systemFontOfSize:14.0f];
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:000000];
        m_titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:m_titleLabel];
        
        m_contentLabel = [[UILabel alloc] init];
        m_contentLabel.font = [UIFont systemFontOfSize:14.0f];
        m_contentLabel.textColor = [UIColor hx_colorWithHexString:000000];
        [self addSubview:m_contentLabel];
        
        m_textField = [[UITextField alloc] init];
        m_textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        m_textField.textColor = [UIColor hx_colorWithHexString:000000];
        m_textField.font = [UIFont systemFontOfSize:14.0f];
        m_textField.delegate = self;
        [self addSubview:m_textField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:m_textField];
    }
    
    return self;
}

-(void)setLeftTitle:(NSString *)title titleWidth:(CGFloat)titleWidth
{
    m_titleLabel.text = title;
    m_titleWidth = titleWidth;
    
    [m_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(m_titleWidth));
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

-(void)setShowContent:(NSString *)content
{
    m_contentLabel.text = content;
    
    [m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_titleLabel.mas_right).offset(30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

-(void)setTextFieldContent:(NSString *)content placeHolder:(NSString *)placeHolder
{
    m_textField.text = content;
    m_textField.placeholder = placeHolder;
    
    [m_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.left.mas_equalTo(m_titleLabel.mas_right).offset(30);
        make.height.mas_equalTo(self.mas_height);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

-(UITextField *)contentTextField
{
    return m_textField;
}

- (void)textFiledEditChanged:(NSNotification *)notifi
{
    UITextField *textField = (UITextField *)notifi.object;
    NSString *text = textField.text;
    
    if ([self.m_delegate respondsToSelector:@selector(inputCellViewEditChanged:)]) {
        [self.m_delegate inputCellViewEditChanged:self];
    }
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.m_delegate respondsToSelector:@selector(inputCellView:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.m_delegate inputCellView:self shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

@end
