//
//  BaseNavControlPage.m
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "BaseNavControlPage.h"
#import "BaseButton.h"

/**
 导航栏按钮位置
 
 - NavigationBarPositionLeft: 左
 - NavigationBarPositionRight: 右
 */
typedef NS_ENUM(NSInteger, NavigationBarPosition) {
    NavigationBarPositionLeft = 0,
    NavigationBarPositionRight = 1,
};

@interface BaseNavControlPage ()

@property (nonatomic, assign) BOOL baseIsDidAppear;
@property (nonatomic, assign) BOOL baseHasPushView;

@end

@implementation BaseNavControlPage

- (void)viewDidLoad {
    [super viewDidLoad];

    // 自动添加返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        [self addBarButtonItemBack];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.baseIsDidAppear = YES;
    self.baseHasPushView = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.baseIsDidAppear = NO;
}

#pragma mark - 导航控制

- (void)popViewController {
    if (self.baseIsDidAppear) {
        [self doPopViewController];
    } else {
        [self performSelector:@selector(doPopViewController) withObject:nil afterDelay:0.5];
    }
}

- (void)doPopViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popViewControllerSkipCount:(NSInteger)countSkip {
    if (countSkip <= 0) {
        [self popViewController];
    } else {
        if (self.baseIsDidAppear) {
            [self doPopViewControllerSkipCount:@(countSkip)];
        } else {
            [self performSelector:@selector(doPopViewControllerSkipCount:) withObject:@(countSkip) afterDelay:0.5];
        }
    }
}

- (void)doPopViewControllerSkipCount:(NSNumber*)numberCount {
    if (self.baseHasPushView) {
        return;
    }
    NSArray* navConArr = self.navigationController.viewControllers;
    NSMutableArray* conArr = [[NSMutableArray alloc] initWithArray:[navConArr subarrayWithRange:NSMakeRange(0, navConArr.count - numberCount.intValue - 1)]];
    [self.navigationController setViewControllers:conArr animated:YES];
}


- (void)pushViewController:(id)con {
    if (con == nil) {
        return;
    }
    if (self.baseIsDidAppear) {
        [self doPushViewController:con];
    } else {
        [self performSelector:@selector(doPushViewController:) withObject:con afterDelay:0.5];
    }
}

- (void)doPushViewController:(id)con {
    if (self.baseHasPushView) {
        return;
    }
    self.baseHasPushView = YES;
    ((UIViewController*)con).hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:con animated:YES];
}

- (void)pushViewController:(id)con skipCount:(NSInteger)countSkip {
    if (con == nil) {
        return;
    }
    if (countSkip <= 0) {
        [self pushViewController:con];
    } else {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:con forKey:@"con"];
        [dic setObject:@(countSkip) forKey:@"skipCount"];
        if (self.baseIsDidAppear) {
            [self doPushViewControllerSkipCount:dic];
        } else {
            [self performSelector:@selector(doPushViewControllerSkipCount:) withObject:dic afterDelay:0.5];
        }
    }
    
}

- (void)doPushViewControllerSkipCount:(NSDictionary*)dic {
    if (self.baseHasPushView) {
        return;
    }
    self.baseHasPushView = YES;
    id con = [dic objectForKey:@"con"];
    NSInteger countSkip = [[dic objectForKey:@"skipCount"] integerValue];
    ((UIViewController*)con).hidesBottomBarWhenPushed = YES;
    NSArray* navConArr = self.navigationController.viewControllers;
    NSMutableArray* conArr = [[NSMutableArray alloc] initWithArray:[navConArr subarrayWithRange:NSMakeRange(0, navConArr.count - countSkip)]];
    [conArr addObject:con];
    [self.navigationController setViewControllers:conArr animated:YES];
}

#pragma mark - 导航按钮

- (void)addBarButtonItemBack {
    WeakObj(self);
    [self addBarButtonItemBackBlock:^(id sender) {
        [selfWeak popViewController];
    }];
}

- (void)addBarButtonItemBackBlock:(ButtonItemBlock)aBlock {
    [self addBarButtonItemLeftTitle:@"<<" block:aBlock];
}

- (void)addBarButtonItemRightImage:(NSString*)imageName block:(ButtonItemBlock)block {
    BaseButton *btn = [self baseButtonImage:imageName block:block];
    [self addBarButtonItemCustomView:btn position:NavigationBarPositionRight];
}

- (void)addBarButtonItemLeftImage:(NSString*)imageName block:(ButtonItemBlock)block {
    BaseButton *btn = [self baseButtonImage:imageName block:block];
    [self addBarButtonItemCustomView:btn position:NavigationBarPositionLeft];
}

- (void)addBarButtonItemRightTitle:(NSString*)title block:(ButtonItemBlock)block {
    BaseButton *btn = [self baseButtonTitle:title block:block];
    [self addBarButtonItemCustomView:btn position:NavigationBarPositionRight];
}

- (void)addBarButtonItemLeftTitle:(NSString*)title block:(ButtonItemBlock)block {
    BaseButton *btn = [self baseButtonTitle:title block:block];
    [self addBarButtonItemCustomView:btn position:NavigationBarPositionLeft];
}

- (void)addBarButtonItemCustomView:(UIView *)customView position:(NavigationBarPosition)position {
    UIBarButtonItem * bbItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    if (position == NavigationBarPositionLeft) {
        self.navigationItem.leftBarButtonItem = bbItem;
    } else {
        self.navigationItem.rightBarButtonItem = bbItem;
    }
}

- (BaseButton *)baseButtonImage:(NSString *)imageName block:(ButtonItemBlock)block {
    BaseButton *btn = [self baseButtonBlock:block];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}

- (BaseButton *)baseButtonTitle:(NSString *)title block:(ButtonItemBlock)block {
    BaseButton *btn = [self baseButtonBlock:block];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (BaseButton *)baseButtonBlock:(ButtonItemBlock)block {
    BaseButton *btn = [BaseButton new];
    btn.click = ^(id sender) {
        if (block) {
            block(sender);
        }
    };
    return btn;
}

@end
