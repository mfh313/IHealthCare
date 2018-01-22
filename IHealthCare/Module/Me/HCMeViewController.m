//
//  HCMeViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCMeViewController.h"
#import "HCNormalGroupCellView.h"
#import "HCMeFooterView.h"
#import "HCAuthIDCardViewController.h"
#import "HCMeProfileUnLoginCellView.h"
#import "HCMeProfileAuthStatusCellView.h"
#import "HCGetUserInfoApi.h"
#import "HCUserModel.h"
#import "HCMyInfoViewController.h"
#import "HCUserAuthStatusViewController.h"
#import "HCFavoritesViewController.h"
#import "HCMyClassesViewController.h"
#import "HCOrderListViewController.h"

@interface HCMeViewController () <MMTableViewInfoDelegate,HCMeProfileCellViewDelegate,HCUserAuthStatusViewControllerDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    
    NSMutableArray<NSMutableArray *> *m_tableSources;
    
    HCUserModel *m_useInfo;
}

@end

@implementation HCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    [self setBackBarButton];
    
    [self addTableSources];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    contentTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [self setFooterView:contentTableView];
    
    [self getUserInfo];
    
    [self reloadMeView];
}

-(void)getUserInfo
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetUserInfoApi *mfApi = [HCGetUserInfoApi new];
    mfApi.userTel = loginService.userPhone;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *responseNetworkData = mfApi.responseNetworkData;
        
        m_useInfo = [HCUserModel yy_modelWithDictionary:responseNetworkData];
        
        UITableView *contentTableView = [m_tableViewInfo getTableView];
        [strongSelf setHeaderView:contentTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)setHeaderView:(UITableView *)contentTableView
{
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 140);
    tableHeaderView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.tableHeaderView = tableHeaderView;
    
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    if ([MFStringUtil isBlankString:loginService.token] || !m_useInfo)
    {
        HCMeProfileUnLoginCellView *profileView = [[HCMeProfileUnLoginCellView alloc] init];
        profileView.m_delegate = self;
        [tableHeaderView addSubview:profileView];
        [profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(contentTableView);
            make.height.mas_equalTo(@(130));
            make.left.mas_equalTo(@(0));
            make.top.mas_equalTo(@(0));
        }];
        
        [profileView layoutProfileViews];
        return;
    }
    
    HCMeProfileAuthStatusCellView *profileView = [[HCMeProfileAuthStatusCellView alloc] init];
    profileView.userInfo = m_useInfo;
    profileView.m_delegate = self;
    [tableHeaderView addSubview:profileView];
    
    [profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentTableView);
        make.height.mas_equalTo(@(130));
        make.left.mas_equalTo(@(0));
        make.top.mas_equalTo(@(0));
    }];
    
    [profileView layoutProfileViews];
}

-(void)setFooterView:(UITableView *)contentTableView
{
    UIView *tableFooterView = [UIView new];
    tableFooterView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    tableFooterView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 260);
    contentTableView.tableFooterView = tableFooterView;
    
    HCMeFooterView *footerView = [HCMeFooterView nibView];
    [tableFooterView addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentTableView);
        make.height.mas_equalTo(@(260));
        make.left.mas_equalTo(@(0));
        make.top.mas_equalTo(@(0));
    }];
    
    [footerView.microProgramImageView sd_setImageWithURL:[NSURL URLWithString:@"http://p2ox6kz2c.bkt.clouddn.com/miniqr_1.png"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self getUserInfo];
}

#pragma mark - HCMeProfileCellViewDelegate
-(void)onClickToAuth:(HCMeProfileCellView *)view
{
    [self showAuthIDCardVC];
}

-(void)onClickShowAuthStatus:(HCUserModel *)userInfo view:(HCMeProfileCellView *)view
{
    HCUserAuthStatusViewController *authStatusVC = [HCUserAuthStatusViewController new];
    authStatusVC.userInfo = m_useInfo;
    authStatusVC.m_delegate = self;
    [self.navigationController pushViewController:authStatusVC animated:YES];
}

#pragma mark - HCUserAuthStatusViewControllerDelegate
-(void)onClickReUserAuth:(HCUserAuthStatusViewController *)controller
{
    [self showAuthIDCardVC];
}

-(void)showAuthIDCardVC
{
    HCAuthIDCardViewController *IDAuthVC = [HCAuthIDCardViewController new];
    [self.navigationController pushViewController:IDAuthVC animated:YES];
}

-(void)onClickProfileCell:(HCMeProfileCellView *)view
{
    HCMyInfoViewController *myInfoVC = [HCMyInfoViewController new];
    myInfoVC.userInfo = m_useInfo;
    [self.navigationController pushViewController:myInfoVC animated:YES];
}

-(void)reloadMeView
{
    [m_tableViewInfo clearAllSection];
    
    for (int i = 0; i < m_tableSources.count; i++)
    {
        MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
        
        NSMutableArray *sectionItem = m_tableSources[i];
        for (int j = 0; j < sectionItem.count; j++)
        {
            NSMutableDictionary *itemInfo = sectionItem[j];
            
            MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeNormalGroupCell:cellInfo:)
                                                                          makeTarget:self
                                                                      actionSel:@selector(onClickSectionCell:)
                                                                        actionTarget:self
                                                                              height:50.0
                                                                            userInfo:nil];
            [cellInfo addUserInfoValue:itemInfo forKey:@"cellData"];
            
            [sectionInfo addCell:cellInfo];
        }
        
        [m_tableViewInfo addSection:sectionInfo];
    }
}

- (void)makeNormalGroupCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCNormalGroupCellView *cellView = [HCNormalGroupCellView nibView];
        cell.m_subContentView = cellView;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }

    HCNormalGroupCellView *cellView = (HCNormalGroupCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;

    NSMutableDictionary *itemInfo =  [cellInfo getUserInfoValueForKey:@"cellData"];
    NSString *imageName = itemInfo[@"image"];
    NSString *title = itemInfo[@"title"];
    
    [cellView setLeftImage:MFImage(imageName)];
    [cellView setTitle:title];
}

-(void)onClickSectionCell:(MMTableViewCellInfo *)cellInfo
{
    NSMutableDictionary *itemInfo =  [cellInfo getUserInfoValueForKey:@"cellData"];
    NSString *key = itemInfo[@"key"];
    if ([key isEqualToString:@"setting"])
    {
        NSLog(@"setting");
    }
    else if ([key isEqualToString:@"collection"])
    {
        [self onClickMyFavoritesVC];
    }
    else if ([key isEqualToString:@"myClasses"])
    {
        [self showMyClassesVC];
    }
    else if ([key isEqualToString:@"orderList"])
    {
        [self showMyOrderListVC];
    }
}

-(void)onClickMyFavoritesVC
{
    HCFavoritesViewController *favoritesVC = [HCFavoritesViewController new];
    [self.navigationController pushViewController:favoritesVC animated:YES];
}

-(void)showMyClassesVC
{
    HCMyClassesViewController *classesVC = [HCMyClassesViewController new];
    [self.navigationController pushViewController:classesVC animated:YES];
}

-(void)showMyOrderListVC
{
    HCOrderListViewController *orderListVC = [HCOrderListViewController new];
    [self.navigationController pushViewController:orderListVC animated:YES];
}

-(void)addTableSources
{
    m_tableSources = [NSMutableArray array];
    
    NSMutableArray *section = [NSMutableArray array];
    
    NSMutableDictionary *records = [NSMutableDictionary dictionary];
    records[@"image"] = @"my_icon_health_records";
    records[@"title"] = @"我的课程";
    records[@"key"] = @"myClasses";
    
    NSMutableDictionary *service = [NSMutableDictionary dictionary];
    service[@"image"] = @"my_icon_service";
    service[@"title"] = @"我的订单";
    service[@"key"] = @"orderList";
    
    [section addObject:records];
    [section addObject:service];
    
    NSMutableArray *section_collection = [NSMutableArray array];
    
    NSMutableDictionary *collection = [NSMutableDictionary dictionary];
    collection[@"image"] = @"my_icon_collection";
    collection[@"title"] = @"我的收藏";
    collection[@"key"] = @"collection";
    
    [section_collection addObject:collection];
    
    [m_tableSources addObject:section];
    [m_tableSources addObject:section_collection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
