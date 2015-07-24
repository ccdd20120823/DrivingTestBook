//
//  MoreDetailViewController.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/11.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (strong,nonatomic)NSArray *array;
@property (copy,nonatomic)NSString  *title;
@end
