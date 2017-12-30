//
//  HCTopCureMainViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCTopCureMainViewController.h"
#import "SPPageController.h"
#import "HCTopCureMainCustomNavbar.h"
#import "HCBestNewsMainViewController.h"
#import "HCHighProductMainViewController.h"

@interface HCTopCureMainViewController ()
{
    HCTopCureMainCustomNavbar *m_navBar;
    
    NSMutableArray<NSMutableDictionary *> *m_tabInfo;
}

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, UIViewController *> *memCacheDic;

@end

@implementation HCTopCureMainViewController

- (void)viewDidLoad
{
    [self initTabInfo];
    self.memCacheDic = [[NSMutableDictionary <NSNumber *, UIViewController *> alloc] init];
    
    [super viewDidLoad];
    
    self.minYPullUp = KNAVIGATIONANDSTATUSBARHEIGHT;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    UIView *statusBGView = [UIView new];
    statusBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusBGView];
    [statusBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(20));
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    
    m_navBar = [HCTopCureMainCustomNavbar nibView];
    [self.view addSubview:m_navBar];
    [m_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(44));
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view);
    }];
}

-(void)initTabInfo
{
    m_tabInfo = [NSMutableArray array];
    
    NSMutableDictionary *news = [NSMutableDictionary dictionary];
    news[@"title"] = @"前沿资讯";
    news[@"key"] = @"news";
    
    NSMutableDictionary *product = [NSMutableDictionary dictionary];
    product[@"title"] = @"高品服务";
    product[@"key"] = @"product";
    
    [m_tabInfo addObject:news];
    [m_tabInfo addObject:product];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
   return 64;
}

- (CGFloat)preferTabHAtIndex:(NSInteger)index
{
    return 44;
}

- (CGRect)preferPageFrame
{
    return CGRectMake(0, 108, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 108 - 50);
}

- (UIViewController *)controllerAtIndex:(NSInteger)index
{
    if (![self.memCacheDic objectForKey:@(index)])
    {
        UIViewController *controller = nil;
        
        NSMutableDictionary *tabItem = m_tabInfo[index];
        NSString *key = tabItem[@"key"];
        if ([key isEqualToString:@"news"])
        {
            HCBestNewsMainViewController *newsMainVC = [HCBestNewsMainViewController new];
            
            controller = newsMainVC;
        }
        else if ([key isEqualToString:@"product"])
        {
            HCHighProductMainViewController *highProductVC = [HCHighProductMainViewController new];
            
            controller = highProductVC;
        }
        
        controller.view.frame = [self preferPageFrame];
        [self.memCacheDic setObject:controller forKey:@(index)];
    }
    
    return [self.memCacheDic objectForKey:@(index)];
}

-(NSInteger)preferPageFirstAtIndex {
    return 1;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
