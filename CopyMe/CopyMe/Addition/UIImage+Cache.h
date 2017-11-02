//
//  UIImage+Cache.h
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cache)

+ (UIImage *)imageWithCacheName:(NSString *)imageName;
+ (UIImage *)imageWithOutCacheName:(NSString *)imageName;

@end
