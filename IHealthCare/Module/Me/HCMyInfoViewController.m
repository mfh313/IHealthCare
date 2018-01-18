//
//  HCMyInfoViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyInfoViewController.h"

@interface HCMyInfoViewController ()
{
    
}

@end

@implementation HCMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self setBackBarButton];
    [self setRightBarButtonTitle:@"保存"];
}

-(void)onClickRightButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
