//
//  MMUIViewController.m
//  YJCustom
//
//  Created by EEKA on 16/9/19.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMUIViewController.h"
#import "MMBarButton.h"

@interface MMUIViewController ()

@end

@implementation MMUIViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    m_cellInfos = [NSMutableArray array];
}

-(void)setWantsFullScreen:(BOOL)wantsFullScreenLayout
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(void)setBackBarButton
{
    UIView *leftNavigationView = [UIView new];
    leftNavigationView.frame = CGRectMake(0, 0, 62, 44);
    MMBarButton *m_btn = [MMBarButton buttonWithType:UIButtonTypeCustom];
    [m_btn addTarget:self action:@selector(onClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    m_btn.frame = CGRectMake(5, 0, 57, 44);
    [m_btn setImage:MFImage(@"title_btn_return_nor") forState:UIControlStateNormal];
    [m_btn setImage:MFImage(@"title_btn_return_press") forState:UIControlStateHighlighted];
    [m_btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 34)];
    [leftNavigationView addSubview:m_btn];
    m_leftBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftNavigationView];
    [self.navigationItem setLeftBarButtonItem:m_leftBarBtnItem];
}

-(void)onClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
