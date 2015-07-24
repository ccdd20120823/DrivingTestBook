//
//  ShowTableViewController.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/23.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "ShowTableViewController.h"
#import "AppDelegate.h"

static NSString *const wrong = @"Wrong";


static NSString *const favorite =@"Favorite";


static NSString *const paper =@"Paper";


static NSString *const number =@"number";


static NSString *const date =@"date";


static NSString *const score = @"score";



@interface ShowTableViewController ()
@property (strong,nonatomic)NSArray *arrayList;
@end

@implementation ShowTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext * context = [appDelegate manageObjectContext];
    NSArray * objects;
    
    if ([self.title isEqualToString:@"我的收藏"]) {
        NSError *error =nil;
    
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:favorite];
    
        objects = [context executeFetchRequest:request error:&error];
        

    }
    else if ([self.title isEqualToString:@"我的错题"]) {
        NSError *error =nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:wrong];
        
        objects = [context executeFetchRequest:request error:&error];
        
        
        
    }
    if ([self.title isEqualToString:@"考试记录"]) {
        NSError *error =nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:paper];
        
        objects = [context executeFetchRequest:request error:&error];
        
        
        
    }
    
    return [objects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext * context = [appDelegate manageObjectContext];
    NSArray * objects;
        //获取题目
    NSBundle *bundle =[NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"question" ofType:@"plist"];
    self.arrayList =[[NSArray alloc]initWithContentsOfFile:plistpath];
    
    
    if ([self.title isEqualToString:@"我的收藏"]) {
        NSError *error =nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:favorite];
        
        objects = [context executeFetchRequest:request error:&error];
        
        
            //排序使之升序
        NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:number ascending:YES];
        request.sortDescriptors =[NSArray arrayWithObject:sort];
        
        
        
        objects = [context executeFetchRequest:request error:&error];
        
        NSString *num = [[objects  objectAtIndex:indexPath.row] valueForKey:number];
        
        
        cell.textLabel.text =[NSString stringWithFormat:@"第%@题",[self.arrayList objectAtIndex:[num intValue]][@"number"]];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"题目:%@",[self.arrayList objectAtIndex:[num intValue]][@"stem"]];
    }
    else if([self.title isEqualToString:@"我的错题"])
        {
        NSError *error =nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:wrong];
       
            //排序使之升序
        NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:number ascending:YES];
        request.sortDescriptors =[NSArray arrayWithObject:sort];

        
        
        objects = [context executeFetchRequest:request error:&error];
        
        
         NSString *num = [[objects  objectAtIndex:indexPath.row] valueForKey:number];
        
        
        cell.textLabel.text =[NSString stringWithFormat:@"第%@题",[self.arrayList objectAtIndex:[num intValue]][@"number"]];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"题目:%@",[self.arrayList objectAtIndex:[num intValue]][@"stem"]];
        }
    else if([self.title isEqualToString:@"考试记录"])
        {
        NSError *error =nil;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:paper];
        
            //排序按时间最近得往前排
        NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:date ascending:NO];
        request.sortDescriptors =[NSArray arrayWithObject:sort];

    
        
        objects = [context executeFetchRequest:request error:&error];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"日期:%@",[[objects  objectAtIndex:indexPath.row] valueForKey:date]];
        cell.textLabel.text =[NSString stringWithFormat:@"得分:%@",[[objects  objectAtIndex:indexPath.row] valueForKey:score]];
        }
    
    return cell;
}


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
