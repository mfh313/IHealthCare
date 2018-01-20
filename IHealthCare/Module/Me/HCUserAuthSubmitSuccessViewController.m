//
//  HCUserAuthSubmitSuccessViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthSubmitSuccessViewController.h"

@interface HCUserAuthSubmitSuccessViewController ()
{
    MMTableViewInfo *m_tableViewInfo;
    UIView *m_contentView;
}

@end

@implementation HCUserAuthSubmitSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"认证提交成功";
    
    m_leftBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    [self.navigationItem setLeftBarButtonItem:m_leftBarBtnItem];
    
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
    
    [self initSuccessView];
}

-(void)initSuccessView
{
    UIImageView *successImageView = [[UIImageView alloc] initWithImage:MFImage(@"my_icon_successful")];
    [m_contentView addSubview:successImageView];
    
    [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(72));
        make.height.mas_equalTo(@(72));
        make.top.mas_equalTo(@(117));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor hx_colorWithHexString:@"F9C255"];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.text = @"提交成功";
    [m_contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(successImageView.mas_bottom).offset(24);
        make.height.mas_equalTo(@(25));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
    subTitleLabel.font = [UIFont systemFontOfSize:18.0f];
    subTitleLabel.text = @"请耐心等待审核结果";
    [m_contentView addSubview:subTitleLabel];
    
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(6);
        make.height.mas_equalTo(@(25));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [doneButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [doneButton addTarget:self action:@selector(onClickDoneButton) forControlEvents:UIControlEventTouchUpInside];
    [m_contentView addSubview:doneButton];
    
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subTitleLabel.mas_bottom).offset(45);
        make.width.mas_equalTo(@(270));
        make.height.mas_equalTo(@(40));
        make.centerX.mas_equalTo(m_contentView.mas_centerX);
    }];
}

-(void)onClickDoneButton
{
    if ([self.m_delegate respondsToSelector:@selector(onClickUserAuthSubmitSuccess)]) {
        [self.m_delegate onClickUserAuthSubmitSuccess];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
