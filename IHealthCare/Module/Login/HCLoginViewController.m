//
//  HCLoginViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/11/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCLoginViewController.h"
#import "HCLoginContentView.h"
#import "HCUserRegisterViewController.h"
#import "HCGetVerifyCodeApi.h"
#import "HCUserLoginApi.h"
#import "HCLoginService.h"

@interface HCLoginViewController () <HCLoginContentViewDelegate,tableViewDelegate,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    HCLoginContentView *m_loginContentView;
    
    UIButton *m_registerBtn;
}

@end

@implementation HCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.m_delegate = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    m_loginContentView = [HCLoginContentView nibView];
    m_loginContentView.m_delegate = self;
    m_loginContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 550);
    m_loginContentView.backgroundColor = [UIColor whiteColor];
    m_tableView.tableHeaderView = m_loginContentView;
    
    m_registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    m_registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [m_registerBtn setTitleColor:[UIColor hx_colorWithHexString:@"F4A523"] forState:UIControlStateNormal];
    [m_registerBtn addTarget:self action:@selector(onClickRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_registerBtn];
    
    [m_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(70));
        make.height.mas_equalTo(@(40));
        make.bottom.equalTo(self.view).with.offset(-10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    #ifdef DEBUG
    [m_loginContentView setInputPhone:@"18603071802"];
//    [m_loginContentView setInputPhone:@"13798228953"];
    #else
    
    #endif
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging && scrollView == m_tableView) {
        [self.view endEditing:YES];
    }
}

- (void)touchesBegan_TableView:(NSSet *)arg1 withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - HCLoginContentViewDelegate
-(void)onClickLogin:(NSString *)phone verificationCode:(NSString *)verificationCode view:(HCLoginContentView *)view
{
    if ([MFStringUtil isBlankString:phone] || [MFStringUtil isBlankString:verificationCode]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    HCUserLoginApi *mfApi = [HCUserLoginApi new];
    mfApi.telephone = phone;
    mfApi.verifyCode = verificationCode;
    mfApi.animatingText = @"正在登录";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
        loginService.userPhone = phone;
        
        NSDictionary *info = mfApi.responseNetworkData;
        loginService.token = info[@"accessToken"];
        
        [[HealthCareViewControllerManager getAppViewControllerManager] launchMainTabViewController];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)onClickRegister:(id)sender
{
    HCUserRegisterViewController *registerVC = [HCUserRegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)onClickWeChatLogin:(HCLoginContentView *)view
{
    
}

-(void)onClickQQLogin:(HCLoginContentView *)view
{
    
}

-(void)onClickGetVerifyCode:(HCLoginContentView *)view
{
    NSString *telephone = [view inputPhoneText];
    if ([MFStringUtil isBlankString:telephone]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    HCGetVerifyCodeApi *mfApi = [HCGetVerifyCodeApi new];
    mfApi.telephone = telephone;
    mfApi.animatingText = @"正在获取验证码";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSString *telephone = mfApi.responseNetworkData[@"telephone"];
        NSString *verifyCode = mfApi.responseNetworkData[@"verifyCode"];
        [m_loginContentView setVerifyCode:verifyCode];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
