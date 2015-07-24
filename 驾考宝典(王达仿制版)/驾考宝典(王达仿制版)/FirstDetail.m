//
//  FirstDetail.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/9.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "FirstDetail.h"
#import "FirstTableViewCell.h"
#import "DetailTableTheTwoTableViewController.h"
#import "TextViewController.h"
#import "DetailCollectionViewController.h"

@interface FirstDetail ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FirstDetail

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




#pragma   delegate table view dataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.selected count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    NSDictionary *dict =self.selected[indexPath.row];
//    if ([self.title isEqualToString: @"报名须知"]){
//        cell.label.text = dict[@"name"];
//
//    }else{
//        NSString *string =[[dict allKeys]lastObject];
//        cell.label.text = string;
//        
//    }
//    cell.image.image=[UIImage imageNamed:@"002"];
//    return cell;
    NSDictionary *dict =self.selected[indexPath.row];
    if ([self.title isEqualToString: @"报名须知"]){
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.label.text = dict[@"name"];
        cell.image.image=[UIImage imageNamed:@"002"];
        return cell;
    }else if([self.title isEqualToString: @"交通标志"]){
        if (indexPath.row == 0) {
            FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellT" forIndexPath:indexPath];
            NSString *string =[[dict allKeys]lastObject];
            cell.label.text = string;
            cell.image.image=[UIImage imageNamed:@"002"];
            return cell;
        }else{
            FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellC" forIndexPath:indexPath];
            NSString *string =[[dict allKeys]lastObject];
            cell.label.text = string;
            cell.image.image=[UIImage imageNamed:@"002"];
            return cell;
        }
    }
    else{
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSString *string =[[dict allKeys]lastObject];
        cell.label.text = string;
        cell.image.image=[UIImage imageNamed:@"002"];
        return cell;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger selectedIndex =[[self.tableView indexPathForSelectedRow]row];
        //判断是哪一个segue
    if([segue.identifier isEqualToString:@"showDetail1"])
        {
            //通过segue的目标视图控制器，获得CitiesTableViewController类的实例
        TextViewController *textView=segue.destinationViewController;
        
         textView.textFiled= self.selected[selectedIndex][@"content"];
        
        
        
        }
    else if([segue.identifier isEqualToString:@"showDetail22"])
        {
            //通过segue的目标视图控制器，获得CitiesTableViewController类的实例
        DetailCollectionViewController *detailCollection=segue.destinationViewController;
        detailCollection.title = [[self.selected[selectedIndex] allKeys]lastObject] ;
        detailCollection.array=[self.selected[selectedIndex] objectForKey:detailCollection.title];
        detailCollection.mark =2;
        
        }else if ([segue.identifier isEqualToString:@"showDetail2"]){
            DetailTableTheTwoTableViewController *detailTable=segue.destinationViewController;
            detailTable.title = [[self.selected[selectedIndex] allKeys]lastObject] ;
            detailTable.array =[self.selected[selectedIndex] objectForKey:detailTable.title];
            detailTable.mark =2;
        }
        else{
            DetailTableTheTwoTableViewController *detailTable=segue.destinationViewController;
            detailTable.title = [[self.selected[selectedIndex] allKeys]lastObject] ;
            detailTable.array =[self.selected[selectedIndex] objectForKey:detailTable.title];
            detailTable.mark =3;
        }

}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
