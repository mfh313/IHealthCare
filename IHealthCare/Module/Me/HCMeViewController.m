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

@interface HCMeViewController () <MMTableViewInfoDelegate,HCMeProfileCellViewDelegate>
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
    if ([MFStringUtil isBlankString:loginService.token])
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - HCMeProfileCellViewDelegate
-(void)onClickToAuth:(HCMeProfileCellView *)view
{
    HCAuthIDCardViewController *IDAuthVC = [HCAuthIDCardViewController new];
    [self.navigationController pushViewController:IDAuthVC animated:YES];
}

-(void)onClickProfileCell:(HCMeProfileCellView *)view
{
    
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
    if ([key isEqualToString:@"setting"]) {
        NSLog(@"setting");
    }
}

-(void)addTableSources
{
    m_tableSources = [NSMutableArray array];
    
    NSMutableArray *section1 = [NSMutableArray array];
    NSMutableDictionary *records = [NSMutableDictionary dictionary];
    records[@"image"] = @"my_icon_health_records";
    records[@"title"] = @"我的课程";
    
    NSMutableDictionary *service = [NSMutableDictionary dictionary];
    service[@"image"] = @"my_icon_service";
    service[@"title"] = @"我的服务";
    //我的服务
    
    [section1 addObject:records];
    [section1 addObject:service];
    
    NSMutableArray *section2 = [NSMutableArray array];
    NSMutableDictionary *focus = [NSMutableDictionary dictionary];
    focus[@"image"] = @"my_icon_focus";
    focus[@"title"] = @"我的关注";
    
    NSMutableDictionary *collection = [NSMutableDictionary dictionary];
    collection[@"image"] = @"my_icon_collection";
    collection[@"title"] = @"我的收藏";
    
//    [section2 addObject:focus];
    [section2 addObject:collection];
    
    NSMutableArray *section3 = [NSMutableArray array];
    NSMutableDictionary *circle = [NSMutableDictionary dictionary];
    circle[@"image"] = @"my_icon_circle";
    circle[@"title"] = @"我的圈子";
    
    NSMutableDictionary *invitation = [NSMutableDictionary dictionary];
    invitation[@"image"] = @"my_icon_invitation";
    invitation[@"title"] = @"邀请好友";
    
    NSMutableDictionary *program = [NSMutableDictionary dictionary];
    program[@"image"] = @"my_icon_program";
    program[@"title"] = @"我的小程序";
    
//    [section3 addObject:circle];
    [section3 addObject:invitation];
//    [section3 addObject:program];
    
    NSMutableArray *section4 = [NSMutableArray array];
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"image"] = @"my_icon_setting";
    setting[@"title"] = @"设置";
    setting[@"key"] = @"setting";
    [section4 addObject:setting];
    
    [m_tableSources addObject:section1];
    [m_tableSources addObject:section2];
    [m_tableSources addObject:section3];
//    [m_tableSources addObject:section4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
