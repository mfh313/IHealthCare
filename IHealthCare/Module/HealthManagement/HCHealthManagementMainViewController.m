//
//  HCHealthManagementMainViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/26.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthManagementMainViewController.h"
#import "SPPageController.h"
#import "HCHealthManagementViewController.h"
#import "HCHealthManagementClassRoomViewController.h"
#import "HCHealthManagementAnalysisViewController.h"
#import "HCHealthManagementMedicalServiceViewController.h"

@interface HCHealthManagementMainViewController ()
{
    NSMutableArray<NSMutableDictionary *> *m_tabInfo;
}

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, UIViewController *> *memCacheDic;

@end

@implementation HCHealthManagementMainViewController

- (void)viewDidLoad {
    
    [self initTabInfo];
    self.memCacheDic = [[NSMutableDictionary <NSNumber *, UIViewController *> alloc] init];
    [super viewDidLoad];
    self.title = @"健康管理";
    
    self.minYPullUp = KNAVIGATIONANDSTATUSBARHEIGHT;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)initTabInfo
{
    m_tabInfo = [NSMutableArray array];
    
    NSMutableDictionary *check = [NSMutableDictionary dictionary];
    check[@"title"] = @"精准检测";
    check[@"key"] = @"check";
    
    NSMutableDictionary *analysis = [NSMutableDictionary dictionary];
    analysis[@"title"] = @"精准分析";
    analysis[@"key"] = @"analysis";
    
    NSMutableDictionary *service = [NSMutableDictionary dictionary];
    service[@"title"] = @"专业服务";
    service[@"key"] = @"service";
    
    NSMutableDictionary *classRoom = [NSMutableDictionary dictionary];
    classRoom[@"title"] = @"大讲堂";
    classRoom[@"key"] = @"classRoom";
    
    [m_tabInfo addObject:check];
    [m_tabInfo addObject:analysis];
    [m_tabInfo addObject:service];
    [m_tabInfo addObject:classRoom];
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
    return 0;
}

- (CGFloat)preferTabHAtIndex:(NSInteger)index
{
    return 44;
}

- (CGRect)preferPageFrame
{
    return CGRectMake(0, 44, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 44);
}

- (UIViewController *)controllerAtIndex:(NSInteger)index
{
    if (![self.memCacheDic objectForKey:@(index)])
    {
        UIViewController *controller = nil;
        
        NSMutableDictionary *tabItem = m_tabInfo[index];
        NSString *key = tabItem[@"key"];
        if ([key isEqualToString:@"check"])
        {
            HCHealthManagementViewController *newsMainVC = [HCHealthManagementViewController new];
            
            controller = newsMainVC;
        }
        else if ([key isEqualToString:@"analysis"])
        {
            HCHealthManagementAnalysisViewController *analysisVC = [HCHealthManagementAnalysisViewController new];
            
            controller = analysisVC;
        }
        else if ([key isEqualToString:@"service"])
        {
            HCHealthManagementMedicalServiceViewController *serviceVC = [HCHealthManagementMedicalServiceViewController new];
            
            controller = serviceVC;
        }
        else if ([key isEqualToString:@"classRoom"])
        {
            HCHealthManagementClassRoomViewController *classRoomVC = [HCHealthManagementClassRoomViewController new];
            
            controller = classRoomVC;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
