//
//  TestViewTController.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/17.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TestViewTController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>

@property (assign,nonatomic)int way;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property int currentNum;

@property int currentRealNum;


//-(void)getTheSubject:(int)currentNum;
@end
