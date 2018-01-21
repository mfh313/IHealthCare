//
//  HCClassRoomDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/8.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCClassRoomDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZFPlayer.h"
#import "HCClassRoomDetailModel.h"
#import "HCSubClassDetailModel.h"
#import "HCGetClassDetailApi.h"
#import "HCPlayerControlView.h"
#import "HCHighProductDetailBottomView.h"
#import "HCClassRoomCourseDescriptionViewController.h"
#import "SPPageController.h"
#import "HCClassRoomCourseSelectionViewController.h"
#import "HCClassRoomCreateOrderViewController.h"
#import "HCAddFavoritesApi.h"

@interface HCClassRoomDetailViewController () <ZFPlayerDelegate,HCHighProductDetailBottomViewDelegate,HCClassRoomCourseSelectionViewControllerDelegate>
{
    UIView *m_naviCoverView;
    ZFPlayerView *_playerView;
    HCPlayerControlView *m_playControlView;
    
    HCHighProductDetailBottomView *m_bottomView;
    
    NSMutableArray<NSMutableDictionary *> *m_tabInfo;
    
    HCClassRoomCourseDescriptionViewController *m_descriptionVC;
    HCClassRoomCourseSelectionViewController *m_courseVC;
}

@property (nonatomic,strong) HCClassRoomDetailModel *detailModel;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) NSString *videoURLString;
@property (nonatomic, strong) UIView *playerFatherView;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, UIViewController *> *memCacheDic;

@end

@implementation HCClassRoomDetailViewController

- (void)viewDidLoad {
    
    [self initTabInfo];
    self.memCacheDic = [[NSMutableDictionary <NSNumber *, UIViewController *> alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    m_naviCoverView = [[UIView alloc] init];
    m_naviCoverView.backgroundColor = [UIColor hx_colorWithHexString:@"000000"];
    [self.view addSubview:m_naviCoverView];
    [m_naviCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(50);
    }];
    
    [self initPlayerView];
    
    m_bottomView = [HCHighProductDetailBottomView nibView];
    m_bottomView.m_delegate = self;
    [self.view addSubview:m_bottomView];
    [m_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];
    
    [super viewDidLoad];
    
    [self getClassRoomDetail];
}

-(void)initTabInfo
{
    m_tabInfo = [NSMutableArray array];
    
    NSMutableDictionary *courseDescription = [NSMutableDictionary dictionary];
    courseDescription[@"title"] = @"课程说明";
    courseDescription[@"key"] = @"courseDescription";
    
    NSMutableDictionary *courseSelection = [NSMutableDictionary dictionary];
    courseSelection[@"title"] = @"课程选集";
    courseSelection[@"key"] = @"courseSelection";
    
    [m_tabInfo addObject:courseDescription];
    [m_tabInfo addObject:courseSelection];
}

- (NSString *)titleForIndex:(NSInteger)index
{
    NSMutableDictionary *tabItem = m_tabInfo[index];
    return tabItem[@"title"];
}

- (UIColor *)titleColorForIndex:(NSInteger)index
{
    return [UIColor hx_colorWithHexString:@"595959"];
}

- (UIColor *)titleHighlightColorForIndex:(NSInteger)index
{
    return [UIColor hx_colorWithHexString:@"F4A523"];
}

- (UIFont *)titleFontForIndex:(NSInteger)index
{
    return [UIFont systemFontOfSize:14.0];
}

- (BOOL)needMarkView
{
    return YES;
}

-(UIColor *)markViewColorForIndex:(NSInteger)index
{
    return [UIColor hx_colorWithHexString:@"F4A523"];
}

- (CGFloat)markViewBottom
{
    return 40;
}

- (CGFloat)preferTabY
{
    [self.view layoutIfNeeded];
    CGFloat pageY = CGRectGetMaxY(self.playerFatherView.frame);
    return pageY;
}

- (CGFloat)preferTabHAtIndex:(NSInteger)index
{
    return 44;
}

- (CGRect)preferPageFrame
{
    [self.view layoutIfNeeded];
    
    CGFloat pageY = [self preferTabY] + 44;
    return CGRectMake(0, pageY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - pageY - 60);
}

- (UIViewController *)controllerAtIndex:(NSInteger)index
{
    if (![self.memCacheDic objectForKey:@(index)])
    {
        UIViewController *controller = nil;
        
        NSMutableDictionary *tabItem = m_tabInfo[index];
        NSString *key = tabItem[@"key"];
        if ([key isEqualToString:@"courseDescription"])
        {
            HCClassRoomCourseDescriptionViewController *descriptionVC = [HCClassRoomCourseDescriptionViewController new];
            descriptionVC.detailModel = self.detailModel;
            
            controller = descriptionVC;
            
            m_descriptionVC = descriptionVC;
        }
        else if ([key isEqualToString:@"courseSelection"])
        {
            HCClassRoomCourseSelectionViewController *courseVC = [HCClassRoomCourseSelectionViewController new];
            courseVC.m_delegate = self;
            courseVC.detailModel = self.detailModel;
            
            controller = courseVC;
            
            m_courseVC = courseVC;
        }
        
        controller.view.frame = [self preferPageFrame];
        [self.memCacheDic setObject:controller forKey:@(index)];
    }
    
    return [self.memCacheDic objectForKey:@(index)];
}

-(NSInteger)preferPageFirstAtIndex {
    return 0;
}

-(BOOL)isSubPageCanScrollForIndex:(NSInteger)index
{
    return YES;
}

- (NSInteger)numberOfControllers
{
    return m_tabInfo.count;
}

-(BOOL)isPreLoad {
    return YES;
}

-(void)getClassRoomDetail
{
    __weak typeof(self) weakSelf = self;
    HCGetClassDetailApi *mfApi = [HCGetClassDetailApi new];
    mfApi.pid = self.crid;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *product = mfApi.responseNetworkData;
        HCClassRoomDetailModel *itemModel = [HCClassRoomDetailModel yy_modelWithDictionary:product];
        strongSelf.detailModel = itemModel;
        
        [strongSelf reloadSubController];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadSubController
{
    m_descriptionVC.detailModel = self.detailModel;
    [m_descriptionVC reloadCourseDescription];
    
    m_courseVC.detailModel = self.detailModel;
    [m_courseVC reloadCourseSelection];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = self.detailModel.name;
        _playerModel.videoURL         = [NSURL URLWithString:self.videoURLString];
        _playerModel.placeholderImageURLString = self.detailModel.imageUrl;
        _playerModel.fatherView       = self.playerFatherView;
    }
    return _playerModel;
}

-(void)initPlayerView
{
    self.playerFatherView = [[UIView alloc] init];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    self.videoURLString = self.detailModel.videoUrl;
    
    _playerView = [[ZFPlayerView alloc] init];
    
    m_playControlView = [HCPlayerControlView new];
    
    [_playerView playerControlView:m_playControlView playerModel:self.playerModel];
    
    // 设置代理
    _playerView.delegate = self;
    
    // 打开预览图
    _playerView.hasPreviewView = YES;
    
}

- (void)zf_playerBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HCHighProductDetailBottomViewDelegate
-(void)onClickBuyProduct
{
    HCClassRoomCreateOrderViewController *createOrderVC = [HCClassRoomCreateOrderViewController new];
    createOrderVC.detailModel = self.detailModel;
    [self.navigationController pushViewController:createOrderVC animated:YES];
}

-(void)onClickCollectionProduct
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCAddFavoritesApi *mfApi = [HCAddFavoritesApi new];
    mfApi.favoriteId = self.detailModel.crid;
    mfApi.userTel = loginService.userPhone;
    mfApi.category = self.detailModel.cid;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:@"收藏成功"];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

#pragma mark - HCClassRoomCourseSelectionViewControllerDelegate
-(void)onSelectClassSubDetal:(HCSubClassDetailModel *)subDetal
                  controller:(HCClassRoomCourseSelectionViewController *)controller
{
    self.videoURLString = subDetal.videoUrl;
    _playerModel.videoURL  = [NSURL URLWithString:self.videoURLString];
    [_playerView resetToPlayNewVideo:_playerModel];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
