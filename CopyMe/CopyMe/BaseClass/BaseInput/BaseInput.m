//
//  BaseInput.m
//  CopyMe
//
//  Created by Keen on 2017/11/2.
//  Copyright © 2017年 Keen. All rights reserved.
//

#import "BaseInput.h"

#define kTextInputOffSet 4.0

#define kColorInputBkg          kColorWhite
#define kColorInputBorder       UIColorFromRGB(194, 194, 194)
#define kColorInputText         kColorGray
#define kColorInputPlaceholder  UIColorFromRGB(203, 203, 203)
#define kCornerRadiusInput      4.0

@implementation BaseTextField

- (id)init {
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init {
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.borderStyle = UITextBorderStyleNone;
    self.backgroundColor = kColorInputBkg;
    self.layer.cornerRadius = kCornerRadiusInput;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = kColorInputBorder.CGColor;
    self.clipsToBounds = YES;
    self.textColor = kColorInputText;
    
    //    self.backgroundColor = kColorViewBkg;
    //    self.clipsToBounds = YES;
    //    self.background = [[UIImage imageNamed:@"input_bkg_side"] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect frameResult = CGRectInset(bounds, kTextInputOffSet, 0);
    
    if (self.leftViewMode == UITextFieldViewModeAlways ||
        self.leftViewMode == UITextFieldViewModeUnlessEditing) {
        frameResult.origin.x += self.leftView.frame.origin.x + self.leftView.frame.size.width;
        frameResult.size.width -= self.leftView.frame.origin.x + self.leftView.frame.size.width;
    }
    
    if (self.rightViewMode == UITextFieldViewModeAlways ||
        self.rightViewMode == UITextFieldViewModeUnlessEditing ||
        self.clearButtonMode == UITextFieldViewModeAlways ||
        self.clearButtonMode == UITextFieldViewModeUnlessEditing) {
        frameResult.size.width -= self.rightView.frame.size.width + 16;
    }
    
    return frameResult;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect frameResult = CGRectInset(bounds, kTextInputOffSet, 0);
    
    if (self.leftViewMode == UITextFieldViewModeAlways) {
        frameResult.origin.x += self.leftView.frame.origin.x + self.leftView.frame.size.width;
        frameResult.size.width -= self.leftView.frame.origin.x + self.leftView.frame.size.width;
    }
    
    if (self.rightViewMode == UITextFieldViewModeAlways ||
        self.clearButtonMode == UITextFieldViewModeAlways) {
        frameResult.size.width -= self.rightView.frame.size.width + 16;
    }
    
    return frameResult;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect frameResult = CGRectInset(bounds, kTextInputOffSet, 0);
    
    if (self.leftViewMode == UITextFieldViewModeAlways ||
        self.leftViewMode == UITextFieldViewModeWhileEditing) {
        frameResult.origin.x += self.leftView.frame.origin.x + self.leftView.frame.size.width;
        frameResult.size.width -= self.leftView.frame.origin.x + self.leftView.frame.size.width;
    }
    
    if (self.rightViewMode == UITextFieldViewModeAlways ||
        self.rightViewMode == UITextFieldViewModeWhileEditing ||
        self.clearButtonMode == UITextFieldViewModeAlways ||
        self.clearButtonMode == UITextFieldViewModeWhileEditing) {
        frameResult.size.width -= self.rightView.frame.size.width + 16;
    }
    
    return frameResult;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    rect.origin.y += (rect.size.height - self.font.lineHeight)/2;
    [self.placeholder drawInRect:rect withAttributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:kColorInputPlaceholder}];
}


@end

@implementation BaseSearchField

- (void)_init {
    [super _init];
    
    UIImageView* iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_icon_search"]];
    self.leftView = iconView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    if (self.leftView) {
        CGFloat offSetX = 8.0;
        CGFloat offSetY = 6.0;
        return CGRectMake(offSetX, offSetY, bounds.size.height - offSetY*2, bounds.size.height - offSetY*2);
    }
    return CGRectZero;
}

@end

@interface BaseTextView ()

@property (nonatomic, strong) UIColor* textColor;

- (void) beginEditing:(NSNotification*) notification;
- (void) endEditing:(NSNotification*) notification;

@end

@implementation BaseTextView

@synthesize placeholder;
@synthesize textColor;

//当用nib创建时会调用此方法
- (void)awakeFromNib {
    [super awakeFromNib];
    //    CGRect frame = self.frame;
    //    UIImageView* bkgView = [[UIImageView alloc] initWithFrame:frame];
    //    bkgView.image = [[UIImage imageNamed:@"input_bkg_side"] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    //    bkgView.autoresizingMask = self.autoresizingMask;
    //    [self.superview insertSubview:bkgView belowSubview:self];
    //    self.frame = CGRectInset(frame, kTextInputOffSet, 2);
    //    self.backgroundColor = kColorClear;
    
    self.backgroundColor = kColorInputBkg;
    self.layer.cornerRadius = kCornerRadiusInput;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = kColorInputBorder.CGColor;
    self.clipsToBounds = YES;
    
    
    NSString* tmpString = [NSString stringWithString:[super text]];
    super.text = nil;
    self.placeholder = tmpString;
    
    textColor = [UIColor blackColor];
}

- (void)dealloc {
    [self removeobserver];
    
    self.placeholder = nil;
}

-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

-(void)removeobserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Setter/Getters
- (void) setPlaceholder:(NSString *)aPlaceholder {
    placeholder = aPlaceholder;
    [self endEditing:nil];
}

- (NSString *) text {
    NSString* text = [super text];
    if ([text isEqualToString:placeholder]) return @"";
    return text;
}

- (void) beginEditing:(NSNotification*) notification {
    NSString* supText = [NSString stringWithString:[super text]];
    if ([supText isEqualToString:placeholder]) {
        super.text = nil;
        //字体颜色
        [super setTextColor:textColor];
    }
    
}

- (void) endEditing:(NSNotification*) notification {
    if ([[super text] isEqualToString:@""] || [super text] == nil) {
        if (placeholder) {
            super.text = placeholder;
        }
        //注释颜色
        [super setTextColor:kColorInputPlaceholder];
    }
}

@end

