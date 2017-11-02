//
//  BaseInput.h
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextField : UITextField

- (void)_init;

@end

@interface BaseSearchField : BaseTextField

@end

@interface BaseTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;     //占位符

-(void)addObserver;//添加通知
-(void)removeobserver;//移除通知

@end

