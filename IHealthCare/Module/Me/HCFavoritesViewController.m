//
//  HCFavoritesViewController.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCFavoritesViewController.h"
#import "HCGetFavoritesApi.h"
#import "HCFavoriteModel.h"
#import "HCFavoritesCellView.h"
#import "HCBestNewsDetailViewController.h"
#import "HCHighProductDetailViewController.h"
#import "HCHealthManagementDetailViewController.h"
#import "HCClassRoomDetailViewController.h"

@interface HCFavoritesViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray *m_favorites;
}

@end

@implementation HCFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    [self getFavorites];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getFavorites];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)getFavorites
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];

    __weak typeof(self) weakSelf = self;
    HCGetFavoritesApi *mfApi = [HCGetFavoritesApi new];
    mfApi.tel = loginService.userPhone;
    mfApi.page = 1;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseData = mfApi.responseNetworkData;
        NSMutableArray *favorites = [NSMutableArray array];
        for (int i = 0; i < responseData.count; i++) {
            HCFavoriteModel *itemModel = [HCFavoriteModel yy_modelWithDictionary:responseData[i]];
            [favorites addObject:itemModel];
        }
        m_favorites = favorites;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
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
    if ([identifier isEqualToString:@"favorite"])
    {
        return [self tableView:tableView favoritesCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView favoritesCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        HCFavoritesCellView *cellView = [HCFavoritesCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCFavoriteModel *itemModel = m_favorites[attachIndex];

    HCFavoritesCellView *cellView = (HCFavoritesCellView *)cell.m_subContentView;
    
    HCCmsCommonModel *favoriteData = itemModel.favoriteData;
    
    [cellView setImageUrl:favoriteData.imageUrl];
    [cellView setTitle:favoriteData.name subTitle:favoriteData.cmsDescription];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    HCFavoriteModel *itemModel = m_favorites[cellInfo.attachIndex];
    
    [self showFavoriteDetail:itemModel];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_favorites.count; i++) {
        
        HCFavoriteModel *itemModel  = m_favorites[i];
        
        MFTableViewCellObject *favorite = [MFTableViewCellObject new];
        favorite.cellHeight = 110.0f;
        favorite.cellReuseIdentifier = @"favorite";
        favorite.attachIndex = i;
        [m_cellInfos addObject:favorite];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
}

-(void)showFavoriteDetail:(HCFavoriteModel *)itemModel
{
    HCCmsCommonModel *favoriteData = itemModel.favoriteData;
    
    NSInteger favCategory = itemModel.category;
    
    if (favCategory == HCFavorite_category_1) //高品服务
    {
        HCHighProductDetailViewController *detailVC = [HCHighProductDetailViewController new];
        detailVC.pid = favoriteData.cmsId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (favCategory == HCFavorite_category_2) //健康管理交易类
    {
        HCHealthManagementDetailViewController *detailVC = [HCHealthManagementDetailViewController new];
        detailVC.hcid = favoriteData.cmsId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (favCategory == HCFavorite_category_4) //资讯显示类
    {
        HCBestNewsDetailViewController *detailVC = [HCBestNewsDetailViewController new];
        detailVC.bid = favoriteData.cmsId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (favCategory == HCFavorite_category_5) //大讲堂类
    {
        HCClassRoomDetailViewController *classRoomDetailVC = [HCClassRoomDetailViewController new];
        classRoomDetailVC.crid = favoriteData.cmsId;
        [self.navigationController pushViewController:classRoomDetailVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
