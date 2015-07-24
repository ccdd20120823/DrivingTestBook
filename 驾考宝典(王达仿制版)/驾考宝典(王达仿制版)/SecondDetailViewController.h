//
//  SecondDetailViewController.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/8.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondDetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *theSelected;
@end
