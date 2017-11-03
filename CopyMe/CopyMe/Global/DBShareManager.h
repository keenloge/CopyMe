//
//  DBShareManager.h
//  CopyMe
//
//  Created by Keen on 2017/11/3.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "DBManager.h"

#define kDBShareQueue [DBShareManager instance].dbQueue

// 公共数据库管理类
@interface DBShareManager : DBVirtualManager

@end

