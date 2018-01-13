//
//  HCCreateOrderViewController.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCreateOrderViewController.h"
#import "HCProductDetailModel.h"
#import "HCCreateOrderApi.h"
#import "HCLoginService.h"
#import "HCPayOrderApi.h"
#import "HCOrderUserAddressModel.h"
#import "HCGetOrderUserAddressApi.h"
#import "HCCreateOrderNullAddressCellView.h"
#import "HCCreateOrderAddressCellView.h"
#import "HCCreateOrderItemCellView.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "HCOrderAddressSelectViewController.h"

@interface HCCreateOrderViewController () <MMTableViewInfoDelegate,HCOrderAddressSelectViewControllerDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    HCOrderUserAddressModel *m_currentAddress;
    
    NSMutableArray *m_carts;
    
    NSInteger m_oid;
}

@end

@implementation HCCreateOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    [self setBackBarButton];
    
    [self initCart];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:contentTableView];
    
    [self getMyAddressInfo];
    
    [self setBottomView];
}

-(void)initCart
{
    m_carts = [NSMutableArray array];
    
    HCOrderItemModel *orderItem = [HCOrderItemModel new];
    orderItem.detailModel = self.detailModel;
    orderItem.pid = self.detailModel.pid;
    orderItem.count = 1;
    
    [m_carts addObject:orderItem];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
        m_currentAddress = addressInfos.lastObject;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    if (m_currentAddress)
    {
        [self addAddressSection];
    }
    else
    {
        [self addNullAddressSection];
    }
    
    [self addDivisionCell];
    [self addCartItems];
}

-(void)addNullAddressSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeNullAddressCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickAddressCell:)
                                                           actionTarget:self
                                                                 height:90.0
                                                               userInfo:nil];
    [cellInfo addUserInfoValue:@"nullAddress" forKey:@"identifier"];
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeNullAddressCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCCreateOrderNullAddressCellView *cellView = [HCCreateOrderNullAddressCellView nibView];
        cell.m_subContentView = cellView;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCCreateOrderNullAddressCellView *cellView = (HCCreateOrderNullAddressCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
}

-(void)addAddressSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeAddressCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickAddressCell:)
                                                           actionTarget:self
                                                                 height:90.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeAddressCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCCreateOrderAddressCellView *cellView = [HCCreateOrderAddressCellView nibView];
        cell.m_subContentView = cellView;

        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCCreateOrderAddressCellView *cellView = (HCCreateOrderAddressCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    [cellView setName:m_currentAddress.name];
    [cellView setPhone:m_currentAddress.phone];
    [cellView setAddressString:m_currentAddress.addr];
}

-(void)addDivisionCell
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDivisionCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:10.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeDivisionCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    cell.contentView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
}

-(void)onClickAddressCell:(MMTableViewCellInfo *)cellInfo
{
    HCOrderAddressSelectViewController *selectVC = [HCOrderAddressSelectViewController new];
    selectVC.m_delegate = self;
    [self.navigationController pushViewController:selectVC animated:YES];
}

#pragma mark - HCOrderAddressSelectViewControllerDelegate


-(void)addCartItems
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    for (int i = 0; i < m_carts.count; i++)
    {
        HCOrderItemModel *orderItem = m_carts[i];
        
        MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeCartItemCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:nil
                                                               actionTarget:self
                                                                     height:118.0
                                                                   userInfo:nil];
        
        [cellInfo addUserInfoValue:@"cartItem" forKey:@"identifier"];
        [cellInfo addUserInfoValue:orderItem forKey:@"cartItem"];
        
        [sectionInfo addCell:cellInfo];
    }
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeCartItemCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCCreateOrderItemCellView *cellView = [HCCreateOrderItemCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCCreateOrderItemCellView *cellView = (HCCreateOrderItemCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    HCOrderItemModel *orderItem =  [cellInfo getUserInfoValueForKey:@"cartItem"];
    
    [cellView setOrderItemModel:orderItem];
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
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [submitButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [submitButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [submitButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [submitButton addTarget:self action:@selector(onClickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(40);
    }];
}

-(void)onClickSubmitButton
{
    [self createOrder];
}

-(void)createOrder
{
    if (!m_currentAddress) {
        [self showTips:@"请添加收货地址"];
        return;
    }
    
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCCreateOrderApi *mfApi = [HCCreateOrderApi new];
    mfApi.userTel = loginService.userPhone;
    mfApi.authCode = loginService.token;
    mfApi.name = m_currentAddress.name;
    mfApi.phone = m_currentAddress.phone;
    mfApi.addr = m_currentAddress.addr;
    mfApi.carts = m_carts;
    mfApi.animatingText = @"正在创建订单...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *createOrderInfo = mfApi.responseNetworkData;
        NSNumber *oid = createOrderInfo[@"oid"];
        m_oid = oid.intValue;
        
        [strongSelf payOrder];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)payOrder
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCPayOrderApi *mfApi = [HCPayOrderApi new];
    mfApi.userTel = loginService.userPhone;
    mfApi.authCode = loginService.token;
    mfApi.oid = m_oid;
    
    mfApi.animatingText = @"正在支付";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *payInfo = mfApi.responseNetworkData;
        [strongSelf bizPayOrder:payInfo];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)bizPayOrder:(NSDictionary *)dict
{
    NSMutableString *stamp  = [dict objectForKey:@"timeStamp"];
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayId"];
    req.nonceStr            = [dict objectForKey:@"nonceStr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dict objectForKey:@"packAge"];
    req.sign                = [dict objectForKey:@"paySign"];
    [WXApi sendReq:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
