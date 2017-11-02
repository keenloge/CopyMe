//
//  AuthLoginPage.m
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "AuthLoginPage.h"
#import "BaseInput.h"
#import "BaseButton.h"
#import "AppDelegate.h"
#import "NSString+Valid.h"
#import "NSTimer+Block.h"

@interface AuthLoginPage ()

@property (nonatomic, strong) BaseTextField *userNameTextField;
@property (nonatomic, strong) BaseTextField *passwordTextField;
@property (nonatomic, strong) BaseButton    *verifyButton;
@property (nonatomic, strong) BaseButton    *loginButton;
@property (nonatomic, strong) UIFont        *inputFont;
@property (nonatomic, strong) NSTimer       *countDownTimer;

@end

@implementation AuthLoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    
    self.userNameTextField.opaque = YES;
    self.passwordTextField.opaque = YES;
    self.loginButton.opaque = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self.countDownTimer isValid]) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有函数

- (BOOL)checkInputForVerifyCode {
    if ([self baseCheckInputNotEmpty:self.userNameTextField]) {
        if ([self.userNameTextField.text isValidPhoneNumber]) {
            return YES;
        } else {
            self.baseMessageNotify = @"无效的手机号码";
        }
    }
    return NO;
}

- (BOOL)checkInputForLogin {
    if ([self baseCheckInputNotEmpty:self.userNameTextField] &&
        [self baseCheckInputNotEmpty:self.passwordTextField]) {
        if ([self.passwordTextField.text isValidVerifyCode]) {
            return YES;
        } else {
            self.baseMessageNotify = @"验证码格式有误";
        }
    }
    return NO;
}

#pragma mark - Getter

- (BaseTextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = [BaseTextField new];
        [self.view addSubview:_userNameTextField];
        
        _userNameTextField.font = self.inputFont;
        _userNameTextField.placeholder = @"请输入手机号";
        _userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        WeakObj(self);
        [_userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.mas_equalTo(30);
            make.centerX.equalTo(selfWeak.view);
            make.height.mas_equalTo(40);
        }];
    }
    
    return _userNameTextField;
}

- (BaseTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [BaseTextField new];
        [self.view addSubview:_passwordTextField];
        
        _passwordTextField.font = self.inputFont;
        _passwordTextField.placeholder = @"请输入验证码";
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        WeakObj(self);
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selfWeak.userNameTextField.mas_bottom).offset(20);
            make.left.height.equalTo(selfWeak.userNameTextField);
            make.right.equalTo(selfWeak.verifyButton.mas_left);
        }];
    }
    
    return _passwordTextField;
}

- (BaseButton *)verifyButton {
    if (!_verifyButton) {
        _verifyButton = [BaseButton new];
        [self.view addSubview:_verifyButton];
        
        [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyButton setTitleColor:kColorBlack forState:UIControlStateNormal];
        
        WeakObj(self);
        _verifyButton.click = ^(id sender) {
            if ([selfWeak checkInputForVerifyCode]) {
                // 需要开启倒计时
                selfWeak.verifyButton.userInteractionEnabled = NO;
                __block NSInteger countDown = 10;
                selfWeak.countDownTimer = [NSTimer hb_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
                    if (countDown <= 0) {
                        [selfWeak.countDownTimer invalidate];
                        selfWeak.countDownTimer = nil;
                        selfWeak.verifyButton.userInteractionEnabled = YES;
                        [selfWeak.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    } else {
                        NSString *tempTitle = [NSString stringWithFormat:@"%zd秒", countDown--];
                        [selfWeak.verifyButton setTitle:tempTitle forState:UIControlStateNormal];
                    }
                }];
                [selfWeak.countDownTimer fire];
                
                [selfWeak.passwordTextField becomeFirstResponder];
            }
        };
        
        [_verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(selfWeak.passwordTextField);
            make.right.equalTo(selfWeak.userNameTextField);
        }];
    }
    return _verifyButton;
}

- (BaseButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [BaseButton new];
        [self.view addSubview:_loginButton];
        
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kColorBlack forState:UIControlStateNormal];
        
        WeakObj(self);
        _loginButton.click = ^(id sender) {
            if ([selfWeak checkInputForLogin]) {
                // 开始登录请求
                [[AppDelegate instance] userDidLogin];
            }
        };
        
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selfWeak.passwordTextField.mas_bottom).offset(20);
            make.left.mas_equalTo(50);
            make.centerX.equalTo(selfWeak.view);
            make.height.mas_equalTo(40);
        }];
    }
    return _loginButton;
}

- (UIFont *)inputFont {
    if (!_inputFont) {
        _inputFont = [UIFont boldSystemFontOfSize:18];
    }
    return _inputFont;
}

@end
