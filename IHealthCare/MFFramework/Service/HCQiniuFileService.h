//
//  HCQiniuFileService.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/19.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMService.h"
#import <QiniuSDK.h>

@interface HCQiniuFileService : MMService

@property (nonatomic,strong) NSString *token;

-(void)getImageToken;
-(void)uploadImageToQNiu:(UIImage *)image;

@end
