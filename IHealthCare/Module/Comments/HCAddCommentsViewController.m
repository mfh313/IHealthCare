//
//  HCAddCommentsViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCAddCommentsViewController.h"

@interface HCAddCommentsViewController () <UITextFieldDelegate>
{
    UITextView *m_textView;
}

@end

@implementation HCAddCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表评论";
    [self setDismissBackButton];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexString:@"EDEDED"];
    
    m_textView = [[UITextView alloc] init];
    [self.view addSubview:m_textView];
    
    [m_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(12);
        make.height.mas_equalTo(@(120));
        make.left.mas_equalTo(self.view.mas_left).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [commentButton setTitle:@"发表评论" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [commentButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [commentButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [commentButton addTarget:self action:@selector(onClickCommentButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentButton];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(m_textView.mas_bottom).offset(27);
        make.width.mas_equalTo(@(120));
        make.height.mas_equalTo(@(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
}

-(void)onClickCommentButton
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
