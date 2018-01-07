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

@interface HCCreateOrderViewController () <MMTableViewInfoDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    HCOrderUserAddressModel *m_currentAddress;
    
    NSMutableArray *m_carts;
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
    NSLog(@"onClickAddressCell");
}

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
