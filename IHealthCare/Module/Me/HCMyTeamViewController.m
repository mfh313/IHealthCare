//
//  HCMyTeamViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyTeamViewController.h"
#import "HCMyTeamHeaderView.h"
#import "HCGetTeamCustomersApi.h"
#import "HCUserHelper.h"
#import "HCMyCustomerModel.h"
#import "HCMyTeamCellView.h"
#import "HCUserPromoteApi.h"

@interface HCMyTeamViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCMyTeamCellViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<HCMyCustomerModel *> *m_myCustomers;
    
    NSInteger m_currentPage;
    NSInteger m_myCustomersCount;
}

@end

@implementation HCMyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的团队";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    [self getMyTeamCustomers];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getMyTeamCustomers];
    }];
    
    [m_tableView addInfiniteScrollingWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getMyTeamCustomersMore];
    }];
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
    if ([identifier isEqualToString:@"myCustomerHeader"])
    {
        return [self tableView:tableView myCustomerHeaderCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"myCustomer"])
    {
        return [self tableView:tableView myCustomerCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView myCustomerCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCMyTeamCellView *cellView = [HCMyTeamCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCMyCustomerModel *itemModel = m_myCustomers[attachIndex];

    HCMyTeamCellView *cellView = (HCMyTeamCellView *)cell.m_subContentView;
    [cellView setCustomerModel:itemModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView myCustomerHeaderCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCMyTeamHeaderView *cellView = [HCMyTeamHeaderView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    
    HCMyTeamHeaderView *cellView = (HCMyTeamHeaderView *)cell.m_subContentView;
    [cellView setSubTitle:[NSString stringWithFormat:@"团队人数：%@",@(m_myCustomersCount)]];
    
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

-(void)getMyTeamCustomers
{
    m_currentPage = 1;
    
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetTeamCustomersApi *mfApi = [HCGetTeamCustomersApi new];
    mfApi.tel = loginService.userPhone;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseData = mfApi.responseJSONObject;
        NSMutableArray *myCustomers = [NSMutableArray array];
        for (int i = 0; i < responseData.count; i++) {
            HCMyCustomerModel *itemModel = [HCMyCustomerModel yy_modelWithDictionary:responseData[i]];
            [myCustomers addObject:itemModel];
        }
        m_myCustomers = myCustomers;
        
        m_myCustomersCount = ((HCMyCustomerModel *)m_myCustomers.firstObject).count;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)getMyTeamCustomersMore
{
    m_currentPage++;
    
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetTeamCustomersApi *mfApi = [HCGetTeamCustomersApi new];
    mfApi.tel = loginService.userPhone;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.infiniteScrollingView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            m_currentPage--;
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseData = mfApi.responseNetworkData;
        NSMutableArray *myCustomers = [NSMutableArray array];
        for (int i = 0; i < responseData.count; i++) {
            HCMyCustomerModel *itemModel = [HCMyCustomerModel yy_modelWithDictionary:responseData[i]];
            [myCustomers addObject:itemModel];
        }
        
        [m_myCustomers addObjectsFromArray:myCustomers];
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        m_currentPage--;
        [m_tableView.infiniteScrollingView stopAnimating];
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
    
    MFTableViewCellObject *divison = [MFTableViewCellObject new];
    divison.cellHeight = 10.0f;
    divison.cellReuseIdentifier = @"divison";
    [m_cellInfos addObject:divison];
    
    MFTableViewCellObject *myCustomerHeader = [MFTableViewCellObject new];
    myCustomerHeader.cellHeight = 110.0f;
    myCustomerHeader.cellReuseIdentifier = @"myCustomerHeader";
    [m_cellInfos addObject:myCustomerHeader];
    
    MFTableViewCellObject *separator = [MFTableViewCellObject new];
    separator.cellHeight = MFOnePixHeight;
    separator.cellReuseIdentifier = @"separator";
    [m_cellInfos addObject:separator];
    
    for (int i = 0; i < m_myCustomers.count; i++) {
        
        HCMyCustomerModel *itemModel  = m_myCustomers[i];
        
        MFTableViewCellObject *myCustomer = [MFTableViewCellObject new];
        myCustomer.cellHeight = 60.0f;
        myCustomer.cellReuseIdentifier = @"myCustomer";
        myCustomer.attachIndex = i;
        [m_cellInfos addObject:myCustomer];
        
        [m_cellInfos addObject:[self separatorAttachIndex:i]];
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

#pragma mark - HCMyTeamCellViewDelegate
-(void)onClickUpdate:(HCMyCustomerModel *)customerModel cellView:(HCMyTeamCellView *)cellView
{
    __weak typeof(self) weakSelf = self;
    HCUserPromoteApi *mfApi = [HCUserPromoteApi new];
    mfApi.tel = customerModel.userTel;
    
    mfApi.animatingText = @"正在升级...";
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf getMyTeamCustomers];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
