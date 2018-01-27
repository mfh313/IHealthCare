//
//  HCMyCustomerViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyCustomerViewController.h"
#import "HCMyTeamHeaderView.h"
#import "HCMyCustomerColumnHeaderView.h"
#import "HCMyCustomerCellView.h"
#import "HCGetCustomersApi.h"

@interface HCMyCustomerViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSInteger m_currentPage;
}

@end

@implementation HCMyCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的客户";
    [self setBackBarButton];
    
//    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
//    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
//    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    m_tableView.dataSource = self;
//    m_tableView.delegate = self;
//    m_tableView.m_delegate = self;
//    [self.view addSubview:m_tableView];
    
    [self getMyCustomers];
}

-(void)getMyCustomers
{
    m_currentPage = 1;
    
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetCustomersApi *mfApi = [HCGetCustomersApi new];
    mfApi.tel = loginService.userPhone;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseData = mfApi.responseNetworkData;
//        NSMutableArray *classes = [NSMutableArray array];
//        for (int i = 0; i < responseData.count; i++) {
//            HCMyClassesListModel *itemModel = [HCMyClassesListModel yy_modelWithDictionary:responseData[i]];
//            [classes addObject:itemModel];
//        }
//        m_myClasses = classes;
//
//        [strongSelf reloadTableView];
        
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
