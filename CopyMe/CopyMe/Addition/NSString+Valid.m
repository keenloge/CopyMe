//
//  NSString+Valid.m
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)

- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    // 以1开头, 第二位数字为 3,4,5,7,8 最后紧跟9位数字
    return [self isValidateByRegex:@"1[34578]([0-9]){9}"];
}

- (BOOL)isValidVerifyCode {
    // 4位数字
    return [self isValidateByRegex:@"[0-9]{4}"];
}

@end
