//
//  HCCommentsViewController.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCommentsViewController.h"
#import "HCGetCommentsCidApi.h"
#import "HCCommentsAddToolBar.h"
#import "HCAddCommentsViewController.h"

@interface HCCommentsViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCCommentsAddToolBarDelegate,HCAddCommentsViewControllerDelegate>
{
    HCCommentsAddToolBar *m_toolBar;
    
    MFUITableView *m_tableView;
    
    NSMutableArray *m_comments;
}

@end

@implementation HCCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    [self setBackBarButton];
    
    m_toolBar = [HCCommentsAddToolBar nibView];
    m_toolBar.m_delegate = self;
    [self.view addSubview:m_toolBar];
    [m_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];

    [self getComments];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getComments];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)getComments
{
    
}

#pragma mark - HCCommentsAddToolBarDelegate
-(void)onClickWriteButton:(HCCommentsAddToolBar *)toolBar
{
    HCAddCommentsViewController *addCommentsVC = [HCAddCommentsViewController new];
    addCommentsVC.commentedId = self.commentedId;
    addCommentsVC.category = self.cid;
    addCommentsVC.m_delegate = self;
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:addCommentsVC];
    [self presentViewController:rootNav animated:YES completion:nil];
}

#pragma mark - HCAddCommentsViewControllerDelegate
-(void)onAddCommentsSuccess:(HCAddCommentsViewController *)controller
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
