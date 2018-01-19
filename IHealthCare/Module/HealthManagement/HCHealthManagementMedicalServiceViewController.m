//
//  HCHealthManagementMedicalServiceViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthManagementMedicalServiceViewController.h"
#import "HCGetHealthMedicalServiceApi.h"
#import "HCHealthMedicalServiceCellView.h"
#import "HCMedicalServiceDetailModel.h"
#import "HCMedicalServiceDetailViewController.h"

@interface HCHealthManagementMedicalServiceViewController ()<tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCHealthMedicalServiceCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray<HCMedicalServiceDetailModel *> *m_service;
}

@end

@implementation HCHealthManagementMedicalServiceViewController

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
    
    [self getMedicalService];
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getMedicalService];
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
    if ([identifier isEqualToString:@"medicalService"])
    {
        return [self tableView:tableView medicalServiceCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView medicalServiceCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCHealthMedicalServiceCellView *cellView = [HCHealthMedicalServiceCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCMedicalServiceDetailModel *itemModel = m_service[attachIndex];
    
    HCHealthMedicalServiceCellView *cellView = (HCHealthMedicalServiceCellView *)cell.m_subContentView;
    [cellView setMedicalService:itemModel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)getMedicalService
{
    __weak typeof(self) weakSelf = self;
    HCGetHealthMedicalServiceApi *mfApi = [HCGetHealthMedicalServiceApi new];
    mfApi.page = 0;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *medicalServices = [NSMutableArray array];
        NSArray *services = mfApi.responseNetworkData;
        for (int i = 0; i < services.count; i++) {
            HCMedicalServiceDetailModel *itemModel = [HCMedicalServiceDetailModel yy_modelWithDictionary:services[i]];
            [medicalServices addObject:itemModel];
        }
        m_service = medicalServices;
        
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
    
    for (int i = 0; i < m_service.count; i++) {
        HCMedicalServiceDetailModel *itemModel  = m_service[i];
        
        MFTableViewCellObject *medicalService = [MFTableViewCellObject new];
        medicalService.cellHeight = 202.0f;
        medicalService.cellReuseIdentifier = @"medicalService";
        medicalService.attachIndex = i;
        [m_cellInfos addObject:medicalService];
    }
}

#pragma mark - HCHealthMedicalServiceCellViewDelegate
-(void)onClickShowMedicalService:(HCMedicalServiceDetailModel *)itemModel
{
    HCMedicalServiceDetailViewController *detailVC = [HCMedicalServiceDetailViewController new];
    detailVC.detailModel = itemModel;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
