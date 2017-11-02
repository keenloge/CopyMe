//
//  BaseButton.h
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(id sender);

@interface BaseButton : UIButton

@property (nonatomic, copy) ClickBlock click;

@end
