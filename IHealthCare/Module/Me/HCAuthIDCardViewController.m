//
//  HCAuthIDCardViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/24.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCAuthIDCardViewController.h"
#import "HCAuthIDCardFacadeInputView.h"

@interface HCAuthIDCardViewController () <HCAuthIDCardFacadeInputViewDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
}

@end

@implementation HCAuthIDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提交身份证";
    [self setBackBarButton];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 10);
    tableHeaderView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.tableHeaderView = tableHeaderView;
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeIDCardImageCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:200.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
    
    [self setTableFooterView];
}

-(void)setTableFooterView
{
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    
    UIView *tableFooterView = [UIView new];
    tableFooterView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    tableFooterView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 260);
    contentTableView.tableFooterView = tableFooterView;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [nextButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [nextButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [nextButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [nextButton addTarget:self action:@selector(onClickNextButton) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(@(40));
        make.top.mas_equalTo(@(23));
        make.centerX.mas_equalTo(tableFooterView.mas_centerX);
    }];
}

- (void)makeIDCardImageCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCAuthIDCardFacadeInputView *cellView = [HCAuthIDCardFacadeInputView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;

        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
}

#pragma mark - HCAuthIDCardFacadeInputViewDelegate
-(void)onClickContenButton:(HCAuthIDCardFacadeInputView *)view
{
    
}

-(void)onClickNextButton
{
    NSLog(@"onClickNextButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
