//
//  HomeTabBarPage.m
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "HomeTabBarPage.h"
#import "BaseNavigationPage.h"
#import "HomeViewPage.h"
#import "HomeWorkPage.h"
#import "HomeMinePage.h"

@interface HomeTabBarPage ()

@end

@implementation HomeTabBarPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *classArray = @[[HomeViewPage class],
                            [HomeWorkPage class],
                            [HomeMinePage class]];
    
    UIFont *font = [UIFont systemFontOfSize:10];
    
    NSMutableArray *pageArray = [NSMutableArray arrayWithCapacity:3];
    [classArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = obj;
        BaseNavigationPage *navCon = [[BaseNavigationPage alloc] initWithRootViewController:[class new]];
        [pageArray addObject:navCon];
        
        [navCon.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         kColorBlue, NSForegroundColorAttributeName,
                                         font, NSFontAttributeName,
                                         nil] forState:UIControlStateSelected];
        [navCon.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         kColorBlack, NSForegroundColorAttributeName,
                                         font, NSFontAttributeName,
                                         nil] forState:UIControlStateNormal];
    }];
    
    [self setViewControllers:pageArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
