//
//  HCCmsCommonModel.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCmsCommonModel : NSObject

@property (nonatomic,assign) NSInteger category;
@property (nonatomic,strong) NSString *categoryName;
@property (nonatomic,assign) NSInteger cmsId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *cmsDescription;
@property (nonatomic,assign) CGFloat shopPrice;

@end
