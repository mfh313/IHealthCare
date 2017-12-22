//
//  MMNetworkRequest.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/8.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import <YTKNetwork/YTKBatchRequest.h>
#import "YTKBaseRequest+AnimatingAccessory.h"

@interface MMNetworkRequest : YTKRequest

@property (nonatomic, strong, readonly, nullable) id responseNetworkData;

-(BOOL)useGlobalAppToken;
-(id _Nullable )requestArgumentWithToken;
-(BOOL)messageSuccess;
-(NSString*_Nullable)errorMessage;
-(id _Nullable )responseNetworkData;

@end
