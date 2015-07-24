//
//  TestView.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/17.
//  Copyright (c) 2015年 wang. All rights reserved.
//
//屏幕的尺寸
#define SCREENSIZE      [[UIScreen mainScreen]bounds]

    //题目框距离上、左、右的距离为20.0f
#define VIEW_TO_TOP          20.0f
#define VIEW_TO_LEFT          20.0f
#define VIEW_TO_RIGHT          20.0f
#define VIEW_BUTTON           10.0f

    //title距离myView顶部的距离
#define TITLE_TO_VIEW        10.0f
#define TITLE_HEIGHT         28.0f
#define TITLE_WIDTH          80.0f

    //Label的约束参数
#define LABEL_WIDTH     60.0f
#define TITLELABEL_FONT        [UIFont fontWithName:@"Avenir-Medium" size:14]



#import <UIKit/UIKit.h>

@interface TestView : UIView
@property (strong,nonatomic) UIButton *buttonA;
@property (strong,nonatomic) UIButton *buttonB;
@property (strong,nonatomic) UIButton *buttonC;
@property (strong,nonatomic) UIButton *buttonD;

@property (strong,nonatomic) UILabel *AContent;
@property (strong,nonatomic) UILabel *BContent;
@property (strong,nonatomic) UILabel *CContent;
@property (strong,nonatomic) UILabel *DContent;

@property (assign,nonatomic) float r;
@property (assign,nonatomic) float g;
@property (assign,nonatomic) float b;

-(void)createMultipleChoiceQuestionWithSubjectContent:(NSString *)subjectContent subjectImage:(NSString *)subjectImage alternatives:(NSArray *)alternatives answer:(NSString *)answer explain:(NSString *)explain;
-(void)showExplain;

@end
