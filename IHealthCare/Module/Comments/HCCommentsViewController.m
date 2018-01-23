//
//  HCCommentsViewController.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCommentsViewController.h"
#import "HCGetCommentsCidApi.h"

@interface HCCommentsViewController ()
{
    
}

@end

@implementation HCCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    [self setDismissBackButton];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
