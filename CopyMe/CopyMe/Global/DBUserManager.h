//
//  DBUserManager.h
//  CopyMe
//
//  Created by Keen on 2017/11/3.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "DBManager.h"

#define kDBUserQueue [DBUserManager instance].dbQueue

// 用户数据库管理类
@interface DBUserManager : DBVirtualManager


/**
 根据唯一标志更新数据库队列
 
 @param unique 唯一标志
 */
- (void)refreshDBQueue:(NSString *)unique;

@end

