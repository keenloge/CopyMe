//
//  DBUserManager.m
//  CopyMe
//
//  Created by Keen on 2017/11/3.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "DBUserManager.h"

static DBUserManager *_instance;

@interface DBUserManager () <NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSString *unique;

@end

@implementation DBUserManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+ (instancetype)instance {
    return [[self alloc] init];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)refreshDBQueue:(NSString *)unique {
    self.unique = unique;
    [self resetDBQueue];
}

- (NSInteger)dbVersion {
    return 1;
}

- (NSString *)dbFileName {
    NSAssert(self.unique.length > 0, @"用户数据库唯一标志为空");
    return [NSString stringWithFormat:@"DB_User_%@.db", self.unique];
}

- (void)createTableIfNotExist:(FMDatabase *)db {
    NSParameterAssert(db);
}

- (void)stepUpdateDataBase:(FMDatabase *)db fromVersion:(NSInteger)version {
    NSParameterAssert(db);
    NSAssert(version > 0, @"首次安装, 无须升级");
    
    switch (version) {
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}

@end

