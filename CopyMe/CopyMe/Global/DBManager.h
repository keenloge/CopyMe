//
//  DBManager.h
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>


/**
 数据库管理类子类须实现的接口
 */
@protocol DBManagerDelegate

/**
 数据库版本

 @return 版本号 (正整数, 递增)
 */
- (NSInteger)dbVersion;

/**
 数据库文件名

 @return 文件名
 */
- (NSString *)dbFileName;

/**
 新建数据库

 @param db 数据库
 */
- (void)createTableIfNotExist:(FMDatabase *)db;

/**
 逐步更新数据库版本

 @param db 数据库
 @param version 旧版本号
 */
- (void)stepUpdateDataBase:(FMDatabase *)db fromVersion:(NSInteger)version;

@end



@interface DBVirtualManager : NSObject <DBManagerDelegate>

/**
 数据库队列
 */
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

/**
 单例管理器

 @return 单例管理器
 */
+ (instancetype)instance;

/**
 重置数据库队列
 */
- (void)resetDBQueue;

@end
