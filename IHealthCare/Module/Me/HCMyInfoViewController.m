//
//  HCMyInfoViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyInfoViewController.h"
#import "HCMyInfoAvtarCellView.h"
#import "HCMyInfoInputCellView.h"
#import "HCGetUserInfoApi.h"

@interface HCMyInfoViewController () <MMTableViewInfoDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    
    BOOL m_canModifyPhone;
}

@end

@implementation HCMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self setBackBarButton];
    [self setRightBarButtonTitle:@"保存"];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 14);
    tableHeaderView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.tableHeaderView = tableHeaderView;
    
    [self getUserInfo];
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
        strongSelf.userInfo = [HCUserModel yy_modelWithDictionary:responseNetworkData];
        if ([MFStringUtil isBlankString:strongSelf.userInfo.preUserphone])
        {
            m_canModifyPhone = YES;
        }
        else
        {
            m_canModifyPhone = NO;
        }
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    [self addAvtarImageSection];
    [self addDetailInfoSection];
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *prePhone = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickDetailInfoCell:)
                                                           actionTarget:self
                                                                 height:50.0
                                                               userInfo:nil];
    [prePhone addUserInfoValue:@"prePhone" forKey:@"contentKey"];
    
    [sectionInfo addCell:prePhone];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)addAvtarImageSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeAvtarImageCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickAvtarImageCell:)
                                                           actionTarget:self
                                                                 height:80.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)addDetailInfoSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *nameInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickDetailInfoCell:)
                                                           actionTarget:self
                                                                 height:50.0
                                                               userInfo:nil];
    
    [nameInfo addUserInfoValue:@"name" forKey:@"contentKey"];
    
    MMTableViewCellInfo *phoneInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickDetailInfoCell:)
                                                           actionTarget:self
                                                                 height:50.0
                                                               userInfo:nil];
    
    [phoneInfo addUserInfoValue:@"phone" forKey:@"contentKey"];

    
    MMTableViewCellInfo *cityInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                              makeTarget:self
                                                               actionSel:@selector(onClickDetailInfoCell:)
                                                            actionTarget:self
                                                                  height:50.0
                                                                userInfo:nil];
    
    [cityInfo addUserInfoValue:@"city" forKey:@"contentKey"];
    
    [sectionInfo addCell:nameInfo];
    [sectionInfo addCell:phoneInfo];
    [sectionInfo addCell:cityInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeDetailInfoCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HCMyInfoInputCellView *cellView = [[HCMyInfoInputCellView alloc] initWithFrame:cell.contentView.frame];
    cell.m_subContentView = cellView;
    
    NSString *contentKey =  [cellInfo getUserInfoValueForKey:@"contentKey"];
    if ([contentKey isEqualToString:@"name"])
    {
        [cellView setLeftTitle:@"姓名" titleWidth:45];
        [cellView setTextFieldContent:self.userInfo.name placeHolder:@"请输入姓名"];
    }
    else if ([contentKey isEqualToString:@"phone"])
    {
        [cellView setLeftTitle:@"手机号" titleWidth:45];
        [cellView setShowContent:self.userInfo.telephone];
    }
    else if ([contentKey isEqualToString:@"city"])
    {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cellView setLeftTitle:@"城市" titleWidth:45];
        [cellView setShowContent:self.userInfo.address];
    }
    else if ([contentKey isEqualToString:@"prePhone"])
    {
        [cellView setLeftTitle:@"邀请人手机号" titleWidth:90];
        if (m_canModifyPhone)
        {
            [cellView setTextFieldContent:self.userInfo.preUserphone placeHolder:@"请输入邀请人手机号"];
        }
        else
        {
            [cellView setShowContent:self.userInfo.preUserphone];
        }
    }
}

-(void)onClickDetailInfoCell:(MMTableViewCellInfo *)cellInfo
{
    NSString *contentKey =  [cellInfo getUserInfoValueForKey:@"contentKey"];
    if ([contentKey isEqualToString:@"city"])
    {
        NSArray *cityArray = @[@"深圳市",@"北京市",@"上海市",@"广州市"];
        
        __weak typeof(self) weakSelf = self;
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:nil message:nil style:LGAlertViewStyleActionSheet buttonTitles:cityArray cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            NSString *value = cityArray[index];
            strongSelf.userInfo.address = value;
            
            [self reloadTableView];
            
        } cancelHandler:^(LGAlertView * _Nonnull alertView) {
            
        } destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
    }
}

- (void)makeAvtarImageCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCMyInfoAvtarCellView *cellView = [HCMyInfoAvtarCellView nibView];
        cell.m_subContentView = cellView;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCMyInfoAvtarCellView *cellView = (HCMyInfoAvtarCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
}

-(void)onClickAvtarImageCell:(MMTableViewCellInfo *)cellInfo
{
    NSArray *actionArray = @[@"拍照",@"从手机相册选择"];
    
    __weak typeof(self) weakSelf = self;
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:nil message:nil style:LGAlertViewStyleActionSheet buttonTitles:actionArray cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *value = actionArray[index];
        
    } cancelHandler:^(LGAlertView * _Nonnull alertView) {
        
    } destructiveHandler:nil];
    
    [alertView showAnimated:YES completionHandler:nil];
}

-(void)onClickRightButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
