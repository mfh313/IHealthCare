//
//  MMUIViewController.h
//  YJCustom
//
//  Created by EEKA on 16/9/19.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFTableViewCellObject.h"
#import "MMBarButton.h"

@interface MMUIViewController : UIViewController
{
    UIBarButtonItem *m_leftBarBtnItem;
    UIBarButtonItem *m_rightBarBtnItem;
    
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
}

-(void)onClickBackBtn:(id)sender;
-(CGFloat)getLeftBarButtonWidth;
-(CGFloat)getRightBarButtonWidth;
-(UIButton *)getNavigationLeftButton:(id)arg1;
-(id)getNavigationRightButton:(id)arg1;
-(void)setBackBarButton;
-(void)setWantsFullScreen:(BOOL)wantsFullScreenLayout;
-(void)setRightBarButtonTitle:(NSString *)title;
-(void)onClickRightButton:(id)sender;
-(void)setDismissBackButton;
-(void)onClickDismissBackButton:(id)sender;

@end
