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

@interface HCClassRoomDetailViewController () <ZFPlayerDelegate>
{
    ZFPlayerView *_playerView;
}

@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) NSString *videoURLString;
@property (nonatomic, strong) UIView *playerFatherView;

@end

@implementation HCClassRoomDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBarButton];
    
    self.videoURLString = self.itemModel.videoUrl;
    
    self.playerFatherView = [[UIView alloc] init];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.leading.trailing.mas_equalTo(0);
        // 这里宽高比16：9,可自定义宽高比
        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    [self initPlayerView];
    
    // 自动播放，默认不自动播放
    [_playerView autoPlayTheVideo];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = self.itemModel.name;
        _playerModel.videoURL         = [NSURL URLWithString:self.videoURLString];
//        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = self.playerFatherView;
        //        _playerModel.resolutionDic = @{@"高清" : self.videoURL.absoluteString,
        //                                       @"标清" : self.videoURL.absoluteString};
    }
    return _playerModel;
}

-(void)initPlayerView
{
    _playerView = [[ZFPlayerView alloc] init];
    
    /*****************************************************************************************
     *   // 指定控制层(可自定义)
     *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
     *   // 设置控制层和播放模型
     *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
     *   // 等效于 [_playerView playerModel:self.playerModel];
     ******************************************************************************************/
    [_playerView playerControlView:nil playerModel:self.playerModel];
    
    // 设置代理
    _playerView.delegate = self;
    
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    // _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
    
    // 打开下载功能（默认没有这个功能）
    //        _playerView.hasDownload    = YES;
    
    // 打开预览图
    _playerView.hasPreviewView = YES;
    
    //        _playerView.forcePortrait = YES;
    /// 默认全屏播放
    //        _playerView.fullScreenPlay = YES;
}

- (void)zf_playerBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
