//
//  SecondViewController.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/6.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic)UIImage *image;
@property (strong,nonatomic)NSString *name;

@end
