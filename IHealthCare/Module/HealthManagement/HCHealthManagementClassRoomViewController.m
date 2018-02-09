//
//  HCHealthManagementClassRoomViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/26.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthManagementClassRoomViewController.h"
#import "HCGetClassRoomApi.h"
#import "HCClassRoomDetailModel.h"
#import "HCHealthManagementClassRoomCellView.h"
#import "HCClassRoomDetailViewController.h"
#import "HCScrollBannerCellView.h"
#import "HCGetClassesBannerApi.h"

@interface HCHealthManagementClassRoomViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCHealthManagementClassRoomCellViewDelegate,HCScrollBannerCellViewDataSource,HCScrollBannerCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray<HCClassRoomDetailModel *> *m_classRooms;
    
    NSMutableArray *m_bannerData;
    
    NSInteger m_currentPage;
}

@end

@implementation HCHealthManagementClassRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_cellInfos = [NSMutableArray array];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    [self getClassRoom];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getClassRoom];
    }];
    
    [m_tableView addInfiniteScrollingWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getClassRoomMore];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getClassRoom];
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
    if ([identifier isEqualToString:@"classRoom"])
    {
        return [self tableView:tableView classRoomCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"banner"])
    {
        return [self tableView:tableView bannerCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView bannerCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCScrollBannerCellView *cellView = [[HCScrollBannerCellView alloc] initWithFrame:cell.contentView.frame];
        cellView.m_dataSource = self;
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    HCScrollBannerCellView *cellView = (HCScrollBannerCellView *)cell.m_subContentView;
    [cellView reloadBanner];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView classRoomCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCHealthManagementClassRoomCellView *cellView = [HCHealthManagementClassRoomCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCClassRoomDetailModel *itemModel = m_classRooms[attachIndex];
    
    HCHealthManagementClassRoomCellView *cellView = (HCHealthManagementClassRoomCellView *)cell.m_subContentView;
    [cellView setClassRoomDetail:itemModel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)getClassRoom
{
    m_currentPage = 1;
    
    __weak typeof(self) weakSelf = self;
    HCGetClassRoomApi *mfApi = [HCGetClassRoomApi new];
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *classRoomsArray = [NSMutableArray array];
        NSArray *classRooms = mfApi.responseNetworkData;
        for (int i = 0; i < classRooms.count; i++) {
            HCClassRoomDetailModel *itemModel = [HCClassRoomDetailModel yy_modelWithDictionary:classRooms[i]];
            [classRoomsArray addObject:itemModel];
        }
        m_classRooms = classRoomsArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
    
    [self getBannerData];
}

-(void)getClassRoomMore
{
    m_currentPage++;
    
    __weak typeof(self) weakSelf = self;
    HCGetClassRoomApi *mfApi = [HCGetClassRoomApi new];
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.infiniteScrollingView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            m_currentPage--;
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *classRoomsArray = [NSMutableArray array];
        NSArray *classRooms = mfApi.responseNetworkData;
        for (int i = 0; i < classRooms.count; i++) {
            HCClassRoomDetailModel *itemModel = [HCClassRoomDetailModel yy_modelWithDictionary:classRooms[i]];
            [classRoomsArray addObject:itemModel];
        }
        
        [m_classRooms addObjectsFromArray:classRoomsArray];
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        m_currentPage--;
        [m_tableView.infiniteScrollingView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)getBannerData
{
    __weak typeof(self) weakSelf = self;
    HCGetClassesBannerApi *mfApi = [HCGetClassesBannerApi new];
    mfApi.csid = 2;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *data = [NSMutableArray array];
        for (int i = 0; i < responseNetworkData.count; i++) {
            HCClassRoomDetailModel *itemModel = [HCClassRoomDetailModel yy_modelWithDictionary:responseNetworkData[i]];
            [data addObject:itemModel];
        }
        
        m_bannerData = data;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
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
    
    MFTableViewCellObject *banner = [MFTableViewCellObject new];
    banner.cellHeight = 160.0f;
    banner.cellReuseIdentifier = @"banner";
    [m_cellInfos addObject:banner];
    
    for (int i = 0; i < m_classRooms.count; i++) {
        HCClassRoomDetailModel *itemModel  = m_classRooms[i];
        
        MFTableViewCellObject *classRoom = [MFTableViewCellObject new];
        classRoom.cellHeight = 202.0f;
        classRoom.cellReuseIdentifier = @"classRoom";
        classRoom.attachIndex = i;
        [m_cellInfos addObject:classRoom];
    }
}

#pragma mark - HCHealthManagementClassRoomCellViewDelegate
-(void)onClickClassRoomDetail:(HCClassRoomDetailModel *)itemModel
{
    HCClassRoomDetailViewController *classRoomDetailVC = [HCClassRoomDetailViewController new];
    classRoomDetailVC.crid = itemModel.crid;
    classRoomDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:classRoomDetailVC animated:YES];
}

#pragma mark - HCScrollBannerCellViewDataSource
-(NSArray *)imagesURLStringsScrollView:(HCScrollBannerCellView *)cycleScrollView
{
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (int i = 0; i < m_bannerData.count; i++) {
        HCClassRoomDetailModel *itemModel = m_bannerData[i];
        [imagesURLStrings safeAddObject:itemModel.imageUrl];
    }
    
    return imagesURLStrings;
}

#pragma mark - HCScrollBannerCellViewDelegate
-(void)onClickScrollView:(HCScrollBannerCellView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HCClassRoomDetailModel *itemModel = m_bannerData[index];
    [self onClickClassRoomDetail:itemModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
