//
//  HCOrderListViewController.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderListViewController.h"
#import "HCOrderListOrderCellView.h"
#import "HCOrderListOrderInfoCellView.h"
#import "HCOrderListOrderBottomCellView.h"
#import "HCGetOrdersApi.h"
#import "HCOrderListItemModel.h"
#import "HCOrderListPayViewController.h"

@interface HCOrderListViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCOrderListOrderBottomCellViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray *m_orderLists;
}

@end

@implementation HCOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    [self getOrderList];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getOrderList];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_cellInfos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    if ([identifier isEqualToString:@"orderItem"])
    {
        return [self tableView:tableView orderItemCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"orderInfo"])
    {
        return [self tableView:tableView orderInfoCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"toPay"])
    {
        return [self tableView:tableView orderToPayCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"divison"])
    {
        return [self tableView:tableView divisionCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"separator"])
    {
        return [self tableView:tableView separatorCellForIndex:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = identifier;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView orderItemCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        HCOrderListOrderCellView *cellView = [HCOrderListOrderCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCOrderListItemModel *itemModel = m_orderLists[attachIndex];
    
    HCOrderListOrderCellView *cellView = (HCOrderListOrderCellView *)cell.m_subContentView;
    [cellView setOrderListModel:itemModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView orderInfoCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCOrderListOrderInfoCellView *cellView = [HCOrderListOrderInfoCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCOrderListItemModel *itemModel = m_orderLists[attachIndex];
    
    HCOrderListOrderInfoCellView *cellView = (HCOrderListOrderInfoCellView *)cell.m_subContentView;
    [cellView setOrderListModel:itemModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView orderToPayCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCOrderListOrderBottomCellView *cellView = [HCOrderListOrderBottomCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCOrderListItemModel *itemModel = m_orderLists[attachIndex];
    
    HCOrderListOrderBottomCellView *cellView = (HCOrderListOrderBottomCellView *)cell.m_subContentView;
    cellView.attachIndex = attachIndex;
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView divisionCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView separatorCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *separator = [UIView new];
        separator.frame = CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), MFOnePixHeight);
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        separator.backgroundColor = MFCustomLineColor;
        [cell.contentView addSubview:separator];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];

}

-(void)getOrderList
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetOrdersApi *mfApi = [HCGetOrdersApi new];
    mfApi.tel = loginService.userPhone;
    mfApi.page = 0;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseData = mfApi.responseNetworkData;
        NSMutableArray *orders = [NSMutableArray array];
        for (int i = 0; i < responseData.count; i++) {
            HCOrderListItemModel *itemModel = [HCOrderListItemModel yy_modelWithDictionary:responseData[i]];
            [orders addObject:itemModel];
        }
        m_orderLists = orders;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_orderLists.count; i++) {
        
        HCOrderListItemModel *itemModel  = m_orderLists[i];
        
        MFTableViewCellObject *divison = [MFTableViewCellObject new];
        divison.cellHeight = 10.0f;
        divison.cellReuseIdentifier = @"divison";
        divison.attachIndex = i;
        [m_cellInfos addObject:divison];
        
        MFTableViewCellObject *orderItem = [MFTableViewCellObject new];
        orderItem.cellHeight = 118.0f;
        orderItem.cellReuseIdentifier = @"orderItem";
        orderItem.attachIndex = i;
        [m_cellInfos addObject:orderItem];
        
        [m_cellInfos addObject:[self separatorAttachIndex:i]];
        
        MFTableViewCellObject *orderInfo = [MFTableViewCellObject new];
        orderInfo.cellHeight = 43.0f;
        orderInfo.cellReuseIdentifier = @"orderInfo";
        orderInfo.attachIndex = i;
        [m_cellInfos addObject:orderInfo];
        
        if (itemModel.state == HCOrderList_state_1)
        {
            [m_cellInfos addObject:[self separatorAttachIndex:i]];
            
            MFTableViewCellObject *toPay = [MFTableViewCellObject new];
            toPay.cellHeight = 60.0f;
            toPay.cellReuseIdentifier = @"toPay";
            toPay.attachIndex = i;
            [m_cellInfos addObject:toPay];
        }
    }
}

-(MFTableViewCellObject *)separatorAttachIndex:(NSInteger)attachIndex
{
    MFTableViewCellObject *separator = [MFTableViewCellObject new];
    separator.cellHeight = MFOnePixHeight;
    separator.cellReuseIdentifier = @"separator";
    separator.attachIndex = attachIndex;
    return separator;
}

#pragma mark - HCOrderListOrderBottomCellViewDelegate
-(void)onClickToPayOrderList:(NSInteger)attachIndex
{
    HCOrderListItemModel *itemModel  = m_orderLists[attachIndex];
    
    HCOrderListPayViewController *payVC = [HCOrderListPayViewController new];
    payVC.oid = itemModel.oid;
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
