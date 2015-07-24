//
//  SecondDetailViewController.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/8.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "SecondDetailViewController.h"
#import "SecondTableViewCell.h"
@interface SecondDetailViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
         [self setATableViewToHideTheWastedTable:self.tableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setATableViewToHideTheWastedTable:(UITableView *)tableView
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor =[UIColor clearColor];
    
         [tableView setTableFooterView:view];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.theSelected count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dict =self.theSelected[indexPath.row];
    
    cell.imageView.image =[UIImage imageNamed:@"001"];
    cell.label.text = dict[@"name"];
    return cell;
}

@end
