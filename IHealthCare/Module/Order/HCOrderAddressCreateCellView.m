//
//  HCOrderAddressCreateCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressCreateCellView.h"

@interface HCOrderAddressCreateCellView () <UITextFieldDelegate>

@end

@implementation HCOrderAddressCreateCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:m_textField];
    }
    
    return self;
}

-(void)initSubViews
{
    [self initLeftTitleView];
}

-(void)initLeftTitleView
{
    m_titleLabel = [[UILabel alloc] init];
    m_titleLabel.font = [UIFont systemFontOfSize:14.0f];
    m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"0F0F0F"];
    m_titleLabel.text = self.leftTitle;
    [self addSubview:m_titleLabel];
    
    [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.width.mas_equalTo(70);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];
}

-(void)initTextField
{
    m_textField = [[UITextField alloc] init];
    m_textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    m_textField.font = [UIFont systemFontOfSize:14.0f];
    m_textField.textColor = [UIColor hx_colorWithHexString:@"0F0F0F"];
    m_textField.returnKeyType = UIReturnKeyDone;
    m_textField.delegate = self;
    [self addSubview:m_textField];
    
    [m_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_titleLabel.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(50);
    }];
}

-(void)layoutContentViews
{
    m_titleLabel.text = self.leftTitle;
}

- (void)textFiledEditChanged:(NSNotification *)notifi
{
    UITextField *textField = (UITextField *)notifi.object;
    NSString *text = textField.text;
    if ([self.m_delegate respondsToSelector:@selector(orderAddressTextFiledEditChanged:)]) {
        [self.m_delegate orderAddressTextFiledEditChanged:self];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.m_delegate respondsToSelector:@selector(orderAddressCreateCellView:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.m_delegate orderAddressCreateCellView:self shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

-(UITextField *)contentTextField
{
    return m_textField;
}

-(void)setTextFieldValue:(NSString *)text
{
    [m_textField setText:text];
}

-(void)initAccessoryView
{
    m_accessoryView = [[UIImageView alloc] initWithImage:MFImage(@"common_btn_next_nor")];
    [self addSubview:m_accessoryView];
    
    [m_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
}

-(void)initContentLabel
{
    m_contentLabel = [[UILabel alloc] init];
    m_contentLabel.font = [UIFont systemFontOfSize:14.0f];
    m_contentLabel.backgroundColor = [UIColor whiteColor];
    m_contentLabel.textColor = [UIColor hx_colorWithHexString:@"0F0F0F"];
    [self addSubview:m_contentLabel];
    
    m_contentLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickContentLabel)];
    [m_contentLabel addGestureRecognizer:tapGes];
}

-(void)onClickContentLabel
{
    if ([self.m_delegate respondsToSelector:@selector(onClickSelectCity:)]) {
        [self.m_delegate onClickSelectCity:self];
    }
}

-(void)setContentLabelValue:(NSString *)text
{
    [m_contentLabel setText:text];
    
    [m_contentLabel setText:@"深圳"];
}

@end
