//
//  BaseNavControlPage.h
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonItemBlock)(id sender);

@interface BaseNavControlPage : UIViewController

#pragma mark - 导航控制
- (void)popViewController;
- (void)popViewControllerSkipCount:(NSInteger)countSkip;
- (void)pushViewController:(id)con;
- (void)pushViewController:(id)con skipCount:(NSInteger)countSkip;

#pragma mark - 导航按钮
- (void)addBarButtonItemBack;
- (void)addBarButtonItemBackBlock:(ButtonItemBlock)aBlock;
- (void)addBarButtonItemRightImage:(NSString*)imageName block:(ButtonItemBlock)block;
- (void)addBarButtonItemLeftImage:(NSString*)imageName block:(ButtonItemBlock)block;
- (void)addBarButtonItemRightTitle:(NSString*)title block:(ButtonItemBlock)block;
- (void)addBarButtonItemLeftTitle:(NSString*)title block:(ButtonItemBlock)block;

@end
