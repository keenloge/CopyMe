//
//  HomeWorkPage.m
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "HomeWorkPage.h"

@interface HomeWorkPage ()

@end

@implementation HomeWorkPage

- (void)baseInitBehind {
    self.title = @"账务台";
    self.tabBarItem.image = [UIImage imageNamed:@"home_tab_work_n"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_tab_work_d"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
