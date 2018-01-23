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
#import "HCCommentsDetailModel.h"

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
    if ([identifier isEqualToString:@"comment"])
    {
//        return [self tableView:tableView commentCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView commentCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
//        HCFavoritesCellView *cellView = [HCFavoritesCellView nibView];
//        cellView.m_delegate = self;
//        cell.m_subContentView = cellView;
    }
    
//    NSInteger attachIndex = cellInfo.attachIndex;
//    HCFavoriteModel *itemModel = m_favorites[attachIndex];
//
//    HCFavoritesCellView *cellView = (HCFavoritesCellView *)cell.m_subContentView;
//    cellView.index = attachIndex;
//
//    HCCmsCommonModel *favoriteData = itemModel.favoriteData;
//
//    [cellView setImageUrl:favoriteData.imageUrl];
//    [cellView setTitle:favoriteData.name subTitle:favoriteData.cmsDescription];
    
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


-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_comments.count; i++) {
        
        HCCommentsDetailModel *itemModel  = m_comments[i];
        
        MFTableViewCellObject *comment = [MFTableViewCellObject new];
        comment.cellHeight = 84.0f;
        comment.cellReuseIdentifier = @"comment";
        comment.attachIndex = i;
        [m_cellInfos addObject:comment];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
}

-(void)getComments
{
    __weak typeof(self) weakSelf = self;
    HCGetCommentsCidApi *mfApi = [HCGetCommentsCidApi new];
    mfApi.cid = self.cid;
    mfApi.commentedId = self.commentedId;
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
        NSMutableArray *comments = [NSMutableArray array];
        for (int i = 0; i < responseData.count; i++) {
            HCCommentsDetailModel *itemModel = [HCCommentsDetailModel yy_modelWithDictionary:responseData[i]];
            [comments addObject:itemModel];
        }
        m_comments = comments;

        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
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
    [self getComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
