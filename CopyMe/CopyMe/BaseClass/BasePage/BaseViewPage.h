//
//  BaseViewPage.h
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "BaseNavControlPage.h"

@interface BaseViewPage : BaseNavControlPage


/**
 初始化后调用函数
 */
- (void)baseInitBehind;

/**
 检查输入框是否不为空, 当为空时, 自动提示并获取焦点(弹出键盘)

 @param textField 输入框
 @return YES:非空 NO:空
 */
- (BOOL)baseCheckInputNotEmpty:(UITextField *)textField;

@end


@interface BaseViewPage (HUD)

@property (nonatomic, assign) BOOL baseLoading;
@property (nonatomic, strong) NSString *baseLoadingContent;
@property (nonatomic, strong) NSString *baseMessageNotify;

@end

