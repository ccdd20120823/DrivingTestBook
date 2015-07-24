//
//  DetailTableTheTwoTableViewController.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/9.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "DetailTableTheTwoTableViewController.h"
#import "SubjectTableViewCell.h"
#import "DetailCollectionViewController.h"
#import  "MoreDetailViewController.h"


@interface DetailTableTheTwoTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DetailTableTheTwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setATableViewToHideTheWastedTable:self.tableView];
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
#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.dict =self.array[indexPath.row];
    if (cell == nil) {
        cell = [[SubjectTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

            cell.label.text = [[self.dict allKeys]lastObject] ;


    cell.imageView.image=[UIImage imageNamed:@"002"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


        return [self.array  count];

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger selectedIndex =[[self.tableView indexPathForSelectedRow]row];
        //判断是哪一个segue
    if([segue.identifier isEqualToString:@"showMoreDetail1"])
        {
            //通过segue的目标视图控制器，获得CitiesTableViewController类的实例
        DetailCollectionViewController *detailCollection=segue.destinationViewController;
        
        detailCollection.title= [[self.array[selectedIndex] allKeys] lastObject];
        detailCollection.array =[self.array[selectedIndex] objectForKey:detailCollection.title];
        
        }
    else if([segue.identifier isEqualToString:@"showMoreDetail2"])
        {
            //通过segue的目标视图控制器，获得CitiesTableViewController类的实例
        MoreDetailViewController    *moreDetail=segue.destinationViewController;
        moreDetail.title =[[self.array[selectedIndex] allKeys]lastObject];
        moreDetail.array= [self.array[selectedIndex] objectForKey:moreDetail.title];

        
        }
    
}

@end
