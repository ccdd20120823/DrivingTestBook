//
//  autoButton.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/5.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "autoButton.h"

@implementation autoButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
        [self setFrame:frame];
    }
    return self;
}


@end
