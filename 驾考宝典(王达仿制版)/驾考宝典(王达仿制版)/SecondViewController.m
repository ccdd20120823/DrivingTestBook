//
//  SecondViewController.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/6.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "SecondViewController.h"
#import "ScondCollectionViewCell.h"
#import "SecondDetailViewController.h"
#import "MP4ViewController.h"


@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonSubjectTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubjectThree;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSString *StringSubject1;
@property (strong,nonatomic)NSString *StringSubject2;
@property (strong,nonatomic)NSArray *Subject1;
@property (strong,nonatomic)NSArray *Subject2;
@property (strong,nonatomic)NSDictionary *MovieListDict;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (readwrite,nonatomic)BOOL theSubject;
@property (strong,nonatomic) NSString * url;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.image =[UIImage imageNamed:@"icon_detail@2x"];
    self.theSubject=NO;
    self.StringSubject1=@"科目二通关秘籍";
    self.StringSubject2=@"科目三考试须知";
    NSBundle *bundle =[NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"movieList" ofType:@"plist"];
     NSDictionary *dict =[[NSDictionary alloc]initWithContentsOfFile:plistpath];
    self.MovieListDict =dict;
    self.Subject1 = [self.MovieListDict objectForKey:@"科目二通关秘籍"];
    self.Subject2 = [self.MovieListDict objectForKey:@"科目三考试须知"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonSubjectTwoPressed:(id)sender {
    if (self.theSubject ==YES) {
        self.theSubject =NO;
        [UIButton animateKeyframesWithDuration:0.8f delay:0.0f options:
         UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
             
             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.tableView cache:YES];
             
             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.collectionView cache:YES];
             
             [self.tableView reloadData];
             [self.collectionView reloadData];
             
         } completion:nil];
    }

}
- (IBAction)buttonSubjectThreePressed:(id)sender {
    if (self.theSubject==NO) {
        self.theSubject =YES;
        [UIButton animateKeyframesWithDuration:0.8f delay:0.0f options:
         UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.tableView cache:YES];
             
             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.collectionView cache:YES];
             [self.tableView reloadData];
             [self.collectionView reloadData];
             
         } completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.theSubject ==NO) {
        
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (self.theSubject==NO) {
        cell.textLabel.text=self.StringSubject1;
        return cell;
    }
    cell.textLabel.text=self.StringSubject2;
    
    return cell;
}


#pragma mark - Collection View Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.theSubject ==NO) {
        return [self.Subject1 count]/2;
    }
    return [self.Subject2 count]/2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    NSDictionary *dict;
    if (self.theSubject ==NO) {
        dict =self.Subject1[indexPath.section*2+indexPath.row];
    }else{
       dict = self.Subject2[indexPath.section*2+ indexPath.row];
    }

    NSString *imageName =[NSString stringWithFormat:@"%@.jpg",dict[@"image"]];
    NSString *labelName=dict[@"name"];
    cell.imageViewScond.image =[UIImage imageNamed:imageName];
    cell.labelSecond.text =labelName;
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict;
    if (self.theSubject ==NO) {
        dict =self.Subject1[indexPath.section*2+indexPath.row];
    }else{
        dict = self.Subject2[indexPath.section*2+ indexPath.row];
    }
    self.url =dict[@"url"];
    [self methodToTest];
    return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        //判断是哪一个segue
    if([segue.identifier isEqualToString:@"ShowDetail"])
        {
            //通过segue的目标视图控制器，获得CitiesTableViewController类的实例
         SecondDetailViewController *secondDetailViewController=segue.destinationViewController;
        NSString *dict;
        NSArray *selected;
            //表视图选定的行
        if (self.theSubject ==NO) {
            dict =self.StringSubject1;
            selected =self.Subject1;
        }else{
            dict = self.StringSubject2;
            selected =self.Subject2;
        }
        
        
        secondDetailViewController.title =dict;
        secondDetailViewController.theSelected=selected;

        
        
        }
}



-(void)methodToTest
{
    MP4ViewController  *mp4 =[self.storyboard instantiateViewControllerWithIdentifier:@"mp4"];
    mp4.url =self.url;
    [self.navigationController pushViewController:mp4 animated:YES];
    
}




@end
