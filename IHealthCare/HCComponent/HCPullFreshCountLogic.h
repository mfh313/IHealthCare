//
//  HCPullFreshCountLogic.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/21.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCPullFreshCountLogic : NSObject
{
    NSInteger m_currentPage;
    NSInteger m_freshingPage;
}

-(void)setCurrentPage:(NSInteger)page;

@end
