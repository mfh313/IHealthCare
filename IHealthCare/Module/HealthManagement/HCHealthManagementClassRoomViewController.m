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

@interface HCHealthManagementClassRoomViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCHealthManagementClassRoomCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray<HCClassRoomDetailModel *> *m_classRooms;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = identifier;
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
    __weak typeof(self) weakSelf = self;
    HCGetClassRoomApi *mfApi = [HCGetClassRoomApi new];
    mfApi.page = 0;
    
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
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_classRooms.count; i++) {
        HCClassRoomDetailModel *itemModel  = m_classRooms[i];
        
        MFTableViewCellObject *classRoom = [MFTableViewCellObject new];
        classRoom.cellHeight = 230.0f;
        classRoom.cellReuseIdentifier = @"classRoom";
        classRoom.attachIndex = i;
        [m_cellInfos addObject:classRoom];
    }
}

#pragma mark - HCHealthManagementClassRoomCellViewDelegate
-(void)onClickClassRoomDetail:(HCClassRoomDetailModel *)itemModel
{
    HCClassRoomDetailViewController *classRoomDetailVC = [HCClassRoomDetailViewController new];
    classRoomDetailVC.detailModel = itemModel;
    classRoomDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:classRoomDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
