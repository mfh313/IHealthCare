//
//  MFTableViewCellObject.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFTableViewCellObject : NSObject

@property (nonatomic,strong) NSString *cellReuseIdentifier;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) NSInteger attachIndex;
@property (nonatomic,strong) NSString *attachKey;

@end
