//
//  UIImage+Cache.m
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "UIImage+Cache.h"

@implementation UIImage (Cache)

+ (UIImage *)imageWithCacheName:(NSString *)imageName {
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)imageWithOutCacheName:(NSString *)imageName {
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

@end
