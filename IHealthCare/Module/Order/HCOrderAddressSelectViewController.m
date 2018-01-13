//
//  HCOrderAddressSelectViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressSelectViewController.h"
#import "HCOrderUserAddressModel.h"
#import "HCOrderAddressCreateViewController.h"
#import "HCOrderAddressSelectCellView.h"
#import "HCGetOrderUserAddressApi.h"

@interface HCOrderAddressSelectViewController () <HCOrderAddressCreateViewControllerDelegate,MMTableViewInfoDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    NSMutableArray *m_addressInfos;
}

@end

@implementation HCOrderAddressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址";
    [self setBackBarButton];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:contentTableView];
    
    [self setBottomView];
    
    [self getMyAddressInfo];
}

-(void)getMyAddressInfo
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetOrderUserAddressApi *mfApi = [HCGetOrderUserAddressApi new];
    mfApi.userTel = loginService.userPhone;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *addressInfoArray = mfApi.responseNetworkData;
        NSMutableArray *addressInfos = [NSMutableArray array];
        for (int i = 0; i < addressInfoArray.count; i++) {
            HCOrderUserAddressModel *itemModel = [HCOrderUserAddressModel yy_modelWithDictionary:addressInfoArray[i]];
            [addressInfos addObject:itemModel];
        }
        
        m_addressInfos = addressInfos;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    for (int i = 0; i < m_addressInfos.count; i++) {
        MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeAddressCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:@selector(onClickAddressCell:)
                                                               actionTarget:self
                                                                     height:90.0
                                                                   userInfo:nil];
        
        [sectionInfo addCell:cellInfo];
        
        if (i != m_addressInfos.count - 1)
        {
            MMTableViewCellInfo *separator = [MMTableViewCellInfo cellForMakeSel:@selector(makeSeparatorCell:cellInfo:)
                                                                     makeTarget:self
                                                                      actionSel:nil
                                                                   actionTarget:self
                                                                         height:MFOnePixHeight
                                                                       userInfo:nil];
            
            [sectionInfo addCell:separator];
        }
    }
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeSeparatorCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        UIView *separator = [UIView new];
        separator.frame = CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), MFOnePixHeight);
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        separator.backgroundColor = MFCustomLineColor;
        [cell.contentView addSubview:separator];
    }
}

- (void)makeAddressCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCOrderAddressSelectCellView *cellView = [[HCOrderAddressSelectCellView alloc] initWithFrame:cell.contentView.frame];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCOrderAddressSelectCellView *cellView = (HCOrderAddressSelectCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
}

-(void)onClickAddressCell:(MMTableViewCellInfo *)cellInfo
{
    
}

-(void)setBottomView
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];
    
    UIView *separator = [UIView new];
    separator.backgroundColor = MFCustomLineColor;
    [bottomView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom);
        make.width.equalTo(bottomView.mas_width);
        make.height.mas_equalTo(MFOnePixHeight);
    }];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButton setTitle:@"新建地址" forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [bottomButton addTarget:self action:@selector(onClickBottomButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(40);
    }];
}

-(void)onClickBottomButton:(id)sender
{
    HCOrderAddressCreateViewController *controller = [HCOrderAddressCreateViewController new];
    controller.m_delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - HCOrderAddressCreateViewControllerDelegate
-(void)onCreateAddressInfo:(HCOrderAddressCreateViewController *)controller address:(HCOrderUserAddressModel *)address
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
