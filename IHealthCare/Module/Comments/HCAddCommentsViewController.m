//
//  HCAddCommentsViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCAddCommentsViewController.h"
#import "HCAddCommentApi.h"

@interface HCAddCommentsViewController () <UITextFieldDelegate>
{
    UITextView *m_textView;
}

@end

@implementation HCAddCommentsViewController

-(void)onClickDismissBackButton:(id)sender
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表评论";
    [self setDismissBackButton];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexString:@"EDEDED"];
    
    m_textView = [[UITextView alloc] init];
    m_textView.font = [UIFont systemFontOfSize:14.0f];
    m_textView.textColor = [UIColor hx_colorWithHexString:@"595959"];
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
    NSString *commentContent = m_textView.text;
    
    if ([MFStringUtil isBlankString:commentContent]) {
        [self showTips:@"请输入评论内容"];
        return;
    }
    
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCAddCommentApi *mfApi = [HCAddCommentApi new];
    mfApi.commentedId = self.commentedId;
    mfApi.userTel = loginService.userPhone;
    mfApi.category = self.category;
    mfApi.title = self.commentTitle;
    mfApi.content = commentContent;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:@"评论成功"];
        [strongSelf onAddCommentSuccess];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)onAddCommentSuccess
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.m_delegate respondsToSelector:@selector(onAddCommentsSuccess:)]) {
        [self.m_delegate onAddCommentsSuccess:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
