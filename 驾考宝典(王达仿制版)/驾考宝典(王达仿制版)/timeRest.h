//
//  timeRest.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/19.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface timeRest : NSObject
    //定义一个计时器
@property (nonatomic,retain)NSTimer *timer;

-(void)start;

-(void)stop;
@end
