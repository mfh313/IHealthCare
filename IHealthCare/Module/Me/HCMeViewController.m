//
//  HCMeViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCMeViewController.h"
#import "HCMeProfileCellView.h"

@interface HCMeViewController () <MMTableViewInfoDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
}

@end

@implementation HCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    [self setBackBarButton];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    [self reloadMeView];
}

-(void)reloadMeView
{
    [m_tableViewInfo clearAllSection];
    
    [self addProfileSection];
//    [self addFrozenEmployeeSection];
//
//    if ([self needAddressBookCell])
//    {
//        [self getAddressBookAuthor];
//
//        MFTableViewSectionInfo *addressSectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
//        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeAddressBookCell:)
//                                                                 makeTarget:self
//                                                                  actionSel:@selector(synMemberInfo)
//                                                               actionTarget:self
//                                                                     height:90.0f
//                                                                   userInfo:nil];
//        [addressSectionInfo addCell:cellInfo];
//        [m_tableViewInfo addSection:addressSectionInfo];
//    }
//
//    [self addFunctionSection];
}

-(void)addProfileSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeProfileCell:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:130.0f
                                                               userInfo:nil];
    [sectionInfo addCell:cellInfo];
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeProfileCell:(MFTableViewCell *)cell
{
    if (!cell.m_subContentView) {
        HCMeProfileCellView *cellView = [HCMeProfileCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    HCMeProfileCellView *cellView = (HCMeProfileCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;

//    m_loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
//    MShopLoginUserInfo *loginInfo = [m_loginService currentLoginUserInfo];
//
//    [cellView setProfileCellInfo:loginInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
