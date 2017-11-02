//
//  NSString+Valid.h
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)


/**
 是否有效的手机号码

 @return 有效性
 */
- (BOOL)isValidPhoneNumber;


/**
 是否有效的验证码

 @return 有效性
 */
- (BOOL)isValidVerifyCode;

@end
