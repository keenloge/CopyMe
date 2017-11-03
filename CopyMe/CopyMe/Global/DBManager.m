//
//  DBManager.m
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "DBManager.h"

@interface DBVirtualManager ()

@end

@implementation DBVirtualManager

+ (instancetype)instance {
    return [[self alloc] init];
}

- (void)resetDBQueue {
    [self.dbQueue close];
    self.dbQueue = nil;
}

- (NSInteger)currentDBVersionForKey:(NSString *)key {
    NSParameterAssert(key);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:key];
}

- (void)updateDBVersion:(NSInteger)version key:(NSString *)key {
    NSParameterAssert(key);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:version forKey:key];
    [defaults synchronize];
}

- (FMDatabaseQueue *)dbQueue {
    if (!_dbQueue) {
        NSString *fileName = [self dbFileName];
        NSAssert(fileName.length > 0, @"数据库文件名为空");
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject];
        NSString *path = [dir stringByAppendingPathComponent:fileName];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        
        WeakObj(self);
        [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            [selfWeak createTableIfNotExist:db];
            BOOL res = [selfWeak updateIfNeeded:db];
            NSAssert(res, @"数据库升级失败");
        }];
    }
    return _dbQueue;
}

/**
 数据库升级
 
 @param db 数据库
 @return 是否成功
 */
- (BOOL)updateIfNeeded:(FMDatabase *)db {
    NSInteger version = [self currentDBVersionForKey:[self dbFileName]];
    if (version < 1) {
        // 首次安装
        [self updateDBVersion:[self dbVersion] key:[self dbFileName]];
        return YES;
    } else {
        return [self recurUpdate:db fromVersion:version];
    }
}

- (BOOL)recurUpdate:(FMDatabase *)db fromVersion:(NSInteger)version {
    if (version >= [self dbVersion]) {
        // 升级完成
        return YES;
    } else {
        // 升级数据库
        [self stepUpdateDataBase:db fromVersion:version];
        
        // 版本递增
        version++;
        // 更新数据库版本
        [self updateDBVersion:version key:[self dbFileName]];
        
        // 递归更新
        return [self recurUpdate:db fromVersion:version];
    }
}

- (NSInteger)dbVersion {
    NSAssert(NO, @"请在子类中重写此方法");
    return 0;
}

- (NSString *)dbFileName {
    NSAssert(NO, @"请在子类中重写此方法");
    return nil;
}

- (void)createTableIfNotExist:(FMDatabase *)db {
    NSAssert(NO, @"请在子类中重写此方法");
}

- (void)stepUpdateDataBase:(FMDatabase *)db fromVersion:(NSInteger)version {
    NSAssert(NO, @"请在子类中重写此方法");
}

@end
