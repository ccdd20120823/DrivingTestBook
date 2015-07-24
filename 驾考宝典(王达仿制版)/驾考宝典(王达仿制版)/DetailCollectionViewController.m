//
//  DetailCollectionViewController.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/11.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "DetailCollectionViewController.h"
#import "DetailCollectionViewCell.h"
#import  "CustomView.h"
#import  "DoAlertView.h"
#import "HTMLView.h"



@interface DetailCollectionViewController ()
@property (strong,nonatomic)NSString *local;
@property (strong,nonatomic)NSDictionary  *event;
@property (strong,nonatomic) DoAlertView *alert;
@end

@implementation DetailCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.array count]%3==0) {
        return [self.array count]/3;
    }
    else{
    return ([self.array count]/3)+1;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if ([self.array count]%3==0) {
        cell.image.image =[UIImage imageNamed:[self.array objectAtIndex:(indexPath.section*3+indexPath.row)][@"image"]];
        cell.label.text  = [self.array objectAtIndex:(indexPath.section*3+indexPath.row)][@"name"];
    }
    else if ([self.array count]%3==1) {

        if ([self.array count]/3==indexPath.section) {
            if (indexPath.row==1) {
                cell.hidden=YES;
                return cell;
            }
            else if (indexPath.row==2) {
                cell.hidden=YES;
                return cell;
            }
        }
        cell.image.image =[UIImage imageNamed:[self.array objectAtIndex:(indexPath.section*3+indexPath.row)][@"image"]];
        cell.label.text  = [self.array objectAtIndex:(indexPath.section*3+indexPath.row)][@"name"];

        
    }else if([self.array count]%3==2){

        if ([self.array count]/3==indexPath.section) {
            if (indexPath.row==2) {
                cell.hidden=YES;
                return cell;
            }
        }
        cell.image.image =[UIImage imageNamed:[self.array objectAtIndex:(indexPath.section*3+indexPath.row)][@"image"]];
        cell.label.text  = [self.array objectAtIndex:(indexPath.section*3+indexPath.row)][@"name"];
    }
    return cell;
}



- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
   self.event =self.array[indexPath.section*3+indexPath.row];
        //   [self showTheAlert:event[@"name"]];
//    AlertView *alertView =[[AlertView alloc]init];
//    alertView.title =[[UILabel alloc]init];
//    alertView.image =
//    [self.view addSubview:alertView];
    if ([self.title isEqualToString:@"新版交警手势"]) {
            self.local =[NSString stringWithFormat:@"%@",self.event[@"url"]];
            [self methodToWeb];
            return YES;
    }
    else{
        self.alert = nil;
    self.alert =[[DoAlertView alloc]init];
    self.alert.dRound = 2.0;
    self.alert.nAnimationType =DoTransitionStyleLine;
    self.alert.iImage =[UIImage imageNamed:self.event[@"image"]];
    self.alert.nContentMode = DoContentImage;
    self.alert.bDestructive = NO;
    [self.alert doYes:self.event[@"name"] body:self.event[@"info"]
               yes:^(DoAlertView *alertView) {
                   
               }];

    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(onTimerOfViewController) userInfo:nil repeats:NO];
    return YES;
    }

}

- (void)onTimerOfViewController
{
    [self.alert hideAlert];
    self.alert = nil;
}

-(void)methodToWeb
{
    HTMLView  *htmlView =[self.storyboard instantiateViewControllerWithIdentifier:@"htmlView"];
    htmlView.local =self.local;
    htmlView.title =self.event[@"name"];
    [self.navigationController pushViewController:htmlView animated:YES];
    
}
//-(void)showTheAlert:(NSString *)title
//{
//    CustomView *customView =[[CustomView alloc]initWithFrame:CGRectMake(25, 200, 300, 400)];
//    customView.backgroundColor =[UIColor grayColor];
//    customView.title =[[UILabel alloc]initWithFrame:CGRectMake(25, 200, 300, 44)];
//    customView.title.text=title;
//    
//    customView.image =[[UIImageView alloc]initWithFrame:CGRectMake(25, 244, 300, 228)];
//    customView.image.image=[UIImage imageNamed:@"001"];
//    customView.label =[[UILabel alloc]initWithFrame:CGRectMake(25, 912, 300, 44)];
//    
//    customView.button=[[UIButton alloc]initWithFrame:CGRectMake(25, 956, 300, 44)];
//    customView.button.titleLabel.text=@"关闭";
//    [customView addSubview:customView.title];
//    [customView addSubview:customView.image];
//    [customView addSubview:customView.label];
//    [customView addSubview:customView.button];
//    [self.view addSubview:customView];
//}




#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
