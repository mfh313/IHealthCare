//
//  HCAddCommentsViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@class HCAddCommentsViewController;
@protocol HCAddCommentsViewControllerDelegate <NSObject>
@optional
-(void)onAddCommentsSuccess:(HCAddCommentsViewController *)controller;

@end

@interface HCAddCommentsViewController : MMUIViewController

@property (nonatomic,weak) id<HCAddCommentsViewControllerDelegate> m_delegate;
@property (nonatomic,assign) NSInteger commentedId;
@property (nonatomic,assign) NSInteger category;
@property (nonatomic,strong) NSString *commentTitle;

@end
