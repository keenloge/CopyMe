//
//  BaseNavigationPage.m
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "BaseNavigationPage.h"

@interface BaseNavigationPage ()

@end

@implementation BaseNavigationPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self _init];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
        [self _init];
    }
    return self;
}

- (void)_init {
    self.navigationBar.barTintColor = kColorBlue;
    //    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarPosition:barMetrics:)]) {
    //        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bkg_ios7"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    //    } else if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
    //        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bkg"] forBarMetrics:UIBarMetricsDefault];
    //    }
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                 NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                                 }];
}

@end
