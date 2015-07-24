//
//  DetailCollectionViewController.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/11.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionViewController : UICollectionViewController
@property (strong,nonatomic)NSArray *array;
@property (copy,nonatomic)NSString *title;
@property int mark;
@end
