//
//  AuthPreLoginPage.m
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "AuthPreLoginPage.h"
#import "AuthLoginPage.h"
#import "BaseButton.h"

@interface AuthPreLoginPage ()

@property (nonatomic, strong) BaseButton *loginButton;

@end

@implementation AuthPreLoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginButton.opaque = YES;
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



#pragma mark - Getter

- (BaseButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [BaseButton new];
        [self.view addSubview:_loginButton];
        
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        WeakObj(self);
        _loginButton.click = ^(id sender) {
            id con = [AuthLoginPage new];
            [selfWeak pushViewController:con];
        };
        
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 44));
            make.centerX.equalTo(selfWeak.view);
            make.bottom.mas_equalTo(-100);
        }];
    }
    return _loginButton;
}

@end
