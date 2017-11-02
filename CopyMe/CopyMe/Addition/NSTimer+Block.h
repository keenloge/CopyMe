//
//  NSTimer+Block.h
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Block)

+ (NSTimer *)hb_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end
