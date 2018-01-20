//
//  HCUserAuthStatusViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthStatusViewController.h"

@interface HCUserAuthStatusViewController ()
{
    MMTableViewInfo *m_tableViewInfo;
    UIView *m_contentView;
}

@end

@implementation HCUserAuthStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"身份认证";
    [self setBackBarButton];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    m_contentView = [UIView new];
    m_contentView.frame = self.view.bounds;
    m_contentView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.tableHeaderView = m_contentView;
    
    if (self.userInfo.status == HCUserAuthStatus_Fail)
    {
        [self initFailureView];
    }
    else if (self.userInfo.status == HCUserAuthStatus_Authoring)
    {
        [self initAuthingView];
    }
    else if (self.userInfo.status == HCUserAuthStatus_Authorized)
    {
        [self initAuthSuccessView];
    }
}

-(void)initFailureView
{
    UIImageView *failureImageView = [[UIImageView alloc] initWithImage:MFImage(@"my_icon_failure")];
    [m_contentView addSubview:failureImageView];
    
    [failureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(72));
        make.height.mas_equalTo(@(72));
        make.top.mas_equalTo(@(117));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.text = @"认证失败";
    [m_contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(failureImageView.mas_bottom).offset(33);
        make.height.mas_equalTo(@(25));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [button setTitle:@"重新认证" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [button setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [button setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(onClickReAuth) forControlEvents:UIControlEventTouchUpInside];
    [m_contentView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(67);
        make.width.mas_equalTo(@(270));
        make.height.mas_equalTo(@(40));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
}

-(void)onClickReAuth
{
    [self.navigationController popViewControllerAnimated:NO];
    
    if ([self.m_delegate respondsToSelector:@selector(onClickReUserAuth:)]) {
        [self.m_delegate onClickReUserAuth:self];
    }
}

-(void)initAuthingView
{
    UIImageView *authingImageView = [[UIImageView alloc] initWithImage:MFImage(@"my_icon_waiting")];
    [m_contentView addSubview:authingImageView];
    
    [authingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(72));
        make.height.mas_equalTo(@(72));
        make.top.mas_equalTo(@(117));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.text = @"正在认证中...";
    [m_contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(authingImageView.mas_bottom).offset(34);
        make.height.mas_equalTo(@(25));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
}

-(void)initAuthSuccessView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:MFImage(@"my_icon_successful")];
    [m_contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(72));
        make.height.mas_equalTo(@(72));
        make.top.mas_equalTo(@(117));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.text = @"恭喜您！认证已审核成功";
    [m_contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(33);
        make.height.mas_equalTo(@(25));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
