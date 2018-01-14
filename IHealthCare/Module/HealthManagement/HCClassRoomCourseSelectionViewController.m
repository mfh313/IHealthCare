//
//  HCClassRoomCourseSelectionViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCClassRoomCourseSelectionViewController.h"
#import "HCGetSubClassesApi.h"
#import "HCGetSubClassDetailApi.h"
#import "HCSubClassDetailModel.h"
#import "HCClassRoomDetailModel.h"

@interface HCClassRoomCourseSelectionViewController () <MMTableViewInfoDelegate>
{
    NSMutableArray *m_subClassDetails;
    
    MMTableViewInfo *m_tableViewInfo;
    
    NSInteger m_currentSubClass;
}

@end

@implementation HCClassRoomCourseSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:contentTableView];
    
    [self getCourseSelection];
}

-(void)getCourseSelection
{
    __weak typeof(self) weakSelf = self;
    HCGetSubClassesApi *mfApi = [HCGetSubClassesApi new];
    mfApi.crid = self.detailModel.crid;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *responseData = mfApi.responseNetworkData;
        
        NSMutableArray *details = [NSMutableArray array];
        for (int i = 0; i < responseData.count; i++)
        {
            HCSubClassDetailModel *itemModel = [HCSubClassDetailModel yy_modelWithDictionary:responseData[i]];
            
            [details addObject:itemModel];
        }
        
        m_subClassDetails = details;
        
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
    
    for (int i = 0; i < m_subClassDetails.count; i++)
    {
        HCSubClassDetailModel *subDetail = m_subClassDetails[i];
        
        MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:@selector(onClickDetailCell:)
                                                               actionTarget:self
                                                                     height:50
                                                                   userInfo:nil];
        [cellInfo addUserInfoValue:subDetail forKey:@"cellInfo"];
        
        [sectionInfo addCell:cellInfo];
    }
    
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeDetailCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        cell.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCSubClassDetailModel *subDetail =  [cellInfo getUserInfoValueForKey:@"cellInfo"];
    
    NSString *classDetail = [NSString stringWithFormat:@"%@、%@",@(subDetail.seqNumber),subDetail.name];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = classDetail;
    
    if (m_currentSubClass == subDetail.crid)
    {
        cell.textLabel.textColor = [UIColor hx_colorWithHexString:@"F4A523"];
    }
    else
    {
        cell.textLabel.textColor = [UIColor hx_colorWithHexString:@"333333"];
    }
}

-(void)onClickDetailCell:(MMTableViewCellInfo *)cellInfo
{
    HCSubClassDetailModel *subDetail =  [cellInfo getUserInfoValueForKey:@"cellInfo"];
    [self getSubClassDetail:subDetail.crid];
    
}

-(void)getSubClassDetail:(NSInteger)crid
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetSubClassDetailApi *mfApi = [HCGetSubClassDetailApi new];
    mfApi.crid = crid;
    mfApi.userTel = loginService.userPhone;
    mfApi.authCode = loginService.token;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess)
        {
            NSString *errorCode = [mfApi errorCode];
            if ([errorCode isEqualToString:@"200002"])
            {
                [strongSelf showTips:@"请购买此课程"];
            }
            return;
        }
        
        NSDictionary *responseData = mfApi.responseNetworkData;
        HCSubClassDetailModel *subDetail = [HCSubClassDetailModel yy_modelWithDictionary:responseData];
        [strongSelf onSelectItemClass:subDetail];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)onSelectItemClass:(HCSubClassDetailModel *)subDetail
{
    if ([self.m_delegate respondsToSelector:@selector(onSelectClassSubDetal:controller:)]) {
        [self.m_delegate onSelectClassSubDetal:subDetail controller:self];
    }
    
    m_currentSubClass = subDetail.crid;
    [self reloadTableView];
}

-(void)reloadCourseSelection
{
    [self getCourseSelection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
