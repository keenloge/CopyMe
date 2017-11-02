//
//  BaseButton.m
//  CopyMe
//
//  Created by Keen on 2017/11/1.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (instancetype)init {
    if (self = [super init]) {
        [self baseInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    [self addTarget:self action:@selector(baseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)baseButtonPressed:(id)sender {
    if (self.click) {
        self.click(sender);
    }
}

@end
