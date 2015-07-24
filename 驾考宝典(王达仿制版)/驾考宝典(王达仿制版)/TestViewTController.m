//
//  TestViewTController.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/17.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "TestViewTController.h"
#import "AppDelegate.h"
#import "TestView.h"
#import "DataInterface.h"
#import "FirstViewController.h"






static NSString *const wrong = @"Wrong";


static NSString *const favorite =@"Favorite";


static NSString *const paper =@"Paper";


static NSString *const number =@"number";


static NSString *const date =@"date";


static NSString *const score = @"score";


@interface TestViewTController ()


@property (strong,nonatomic)NSArray *arrayList;

@property (strong,nonatomic) NSMutableArray *record;

@property (strong,nonatomic) TestView * view1;


@property (strong,nonatomic) UIButton *button5;//self.view.AContent
@property (strong,nonatomic) UIButton *button6;
@property (strong,nonatomic) UIButton *button7;
@property (strong,nonatomic) UIButton *button8;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (copy,nonatomic) NSString *answer;
@property (assign,nonatomic) BOOL tag;
@property (strong,nonatomic) NSMutableArray *collectNumber;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) UIAlertView *alert1;

@property (strong, nonatomic) UIAlertView *alert2;

@property (strong, nonatomic) UIAlertView *alert3;




@property int minutes;
@property int seconds;

@property int score;
@property (assign,nonatomic) int timeOut;

@end


static TestViewTController *testTViewController;


@implementation TestViewTController
{
    BOOL keyboardVisible;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.timeOut = 2699;
        self.score=0;
            // Do any additional setup after loading the view.
            //获取appDelegate 实例
//                AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
//            
//                NSManagedObjectContext * context = [appDelegate manageObjectContext];
    
            //从plist中取出题目
            //    NSBundle *bundle =[NSBundle mainBundle];
            //    NSString *plistpath = [bundle pathForResource:@"question" ofType:@"plist"];
            //    self.arrayList =[[NSArray alloc]initWithContentsOfFile:plistpath];
            //
            //        int arrayListNum=(int)[self.arrayList  count];
        
        self.view1 = [[TestView alloc]init];
        
        self.record = [NSMutableArray new];
        self.collectNumber = [NSMutableArray new];
        
        self.tag = NO;
        self.currentRealNum = 0;
        [self loadDataInterfaceWithPlistName:@"question"];
        DataInterface *data = [DataInterface new];
        data = self.dataArray[self.currentRealNum];
        self.answer = data.answer;
        [self.view1 createMultipleChoiceQuestionWithSubjectContent:data.subjectContent subjectImage:data.subjectImage alternatives:data.alternatives answer:data.answer explain:data.explain];
        self.scrollView.contentSize = self.view1.frame.size;
        [self.scrollView addSubview:self.view1];
        self.scrollView.backgroundColor = [UIColor clearColor];
        [self buttonAddTatget];
        
            // [self.view1 showExplain];
        
        
        
        
        
    if (self.way == commonTest) {
        [self changeTheTime];
    }
    
            //    NSError *error =nil;
            //
            //    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:normalPaper];
            //
            //    NSArray * objects = [context executeFetchRequest:request error:&error];
            //    if (objects == nil) {
            //        NSLog(@"查询结果为空");
            //    }
            //
            //
            //        //遍历被管理对象的数组,删除所有的数据
            //    for (NSManagedObject * oneObject  in objects) {
            //        [context deleteObject:oneObject];
            //    }
            //
            //
            //
            //
            //
            //
            //    for (int i=1;  i<=commonTestCont ; i++) {
            //        int normalTest =arc4random_uniform((int)[self.dataArray count]);
            //                //搜索准则
            //        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:normalPaper];
            //
            //        NSError * error;
            //
            //            //根据查询要求返回数组
            //
            //        NSArray * objects = [context executeFetchRequest:request error:&error];
            //        if (objects == nil) {
            //            NSLog(@"查询结果为空 存盘");
            //        }
            //        NSManagedObject * theSubject = nil;
            //
            //        
            //
            //            theSubject =[NSEntityDescription   insertNewObjectForEntityForName:normalPaper inManagedObjectContext:context];
            //    
            //        [theSubject setValue:[NSNumber numberWithInt:i] forKey:persentNum];
            //        [theSubject setValue:[NSNumber numberWithInt:normalTest] forKey:subjectNum];
            //        [theSubject setValue:nil forKey:subjectMyChoice];
            //        [appDelegate saveContext];
        
            //    }
        
            //    [self getTheSubject:self.currentNum];

    
 
}

    

//定义计时器，在时间结束时自动交卷
-(void)changeTheTime
{
        //static int timeout =2699;
    
    dispatch_queue_t queque =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t  _timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0,0,queque);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (self.timeOut <=0) {
            dispatch_source_cancel(_timer);
            [self timeOutTheFormal];
                //            dispatch_release(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }else{
            self.minutes =self.timeOut/60;
            self.seconds =self.timeOut%60;
            dispatch_async(dispatch_get_main_queue(), ^{
                 self.time.text =[NSString stringWithFormat:@"%d:%d",self.minutes,self.seconds];
            });
            

            self.timeOut--;
        }
    });
    dispatch_resume(_timer);
}


-(void)timeOutTheFormal
{
    NSString *theScore =[NSString stringWithFormat:@"您已经超时，您所得的总分为%d",self.score];
    NSString *theEnd;
    if (self.score>=90) {
        theEnd =[NSString stringWithFormat:@",恭喜您，及格"];
    }else {
        theEnd =[NSString stringWithFormat:@",您还要在补习一下,不及格"];
    }
    theScore= [theScore stringByAppendingString:theEnd];

    
    self.alert3 =[[UIAlertView alloc]initWithTitle:@"对不起" message:theScore delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
}

-(void)buttonAddTatget{
    [self.view1.buttonA addTarget:self action:@selector(showExplainA) forControlEvents:UIControlEventTouchDown];
    [self.view1.buttonB addTarget:self action:@selector(showExplainB) forControlEvents:UIControlEventTouchDown];
    [self.view1.buttonC addTarget:self action:@selector(showExplainC) forControlEvents:UIControlEventTouchDown];
    [self.view1.buttonD addTarget:self action:@selector(showExplainD) forControlEvents:UIControlEventTouchDown];
}

    
//-(void)getTheSubject:(int)currentNum
//    {
//    self.view1 = [[TestView alloc]init];
//    self.tag = NO;
//    
//        //从数据库里取出需要的题号number
//    
//    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
//    
//    NSManagedObjectContext * context = [appDelegate manageObjectContext];
//    
//        //搜索准则
//    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:normalPaper];
//    
//    NSError * error;
//    
//        //根据查询要求返回数组
//    
//    NSArray * objects = [context executeFetchRequest:request error:&error];
//    if (objects == nil) {
//        NSLog(@"查询结果为空");
//    }
//    
//    
//        //遍历被管理对象的数组
//    for (NSManagedObject * oneObject  in objects) {
//        int  subjectNumber = [[oneObject valueForKey:subjectNum] intValue];
//        int  persentNumber = [[oneObject valueForKey:persentNum] intValue];
//
//        
//        if( currentNum ==persentNumber) {
//            self.currentRealNum =subjectNumber;
//            
//            break;
//        }
//        
//    }
//    NSString *subjectContent;
//    NSString *subjectImage;
//    NSArray *alternatives;
//    NSString *explain;
//    for (id object in self.arrayList) {
//        if ([object[@"number"] intValue]==(self.currentRealNum+1)) {
//            subjectContent =object[@"stem"];
//            subjectImage =object[@"image"];
//            alternatives =@[object[@"A"],object[@"B"],object[@"C"],object[@"D"]];
//            explain=object[@"explain"];
//            self.answer =object[@"answer"];
//        }
//    }
//    
//        //题目
////    NSString *subjectContent = @"117.醉酒驾驶机动车在道路上行驶会受到什么处罚?";
////    NSString *subjectImage = @"picture1";
////    NSArray *alternatives = @[@"处两年一下图形",@"处拘役,并处罚金",@"处两年以上徒刑",@"处管制,并处罚金"];
////    self.answer = @"B";
////    NSString *explain = @"最新2013酒驾处罚标准和醉驾处罚新规定:醉酒驾驶机动车辆,吊销驾照,5年内不得重新获取驾照,经过判决后处以拘役,并处罚金。所以选B。最新2013酒驾处罚标准和醉驾处罚新规定:醉酒驾驶机动车辆,吊销驾照,5年内不得重新获取驾照,经过判决后处以拘役,并处罚金。所以选B。";
////    
//   
//    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    //将错的题号放入错题题库
-(void)addTheWrongNum
{
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext * context = [appDelegate manageObjectContext];
        //搜索准则
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:wrong];
    
    NSError * error;
    int i=0;
        //根据查询要求返回数组
    
    NSArray * objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"查询结果为空");
    }
    NSManagedObject *theObject;
    
        //遍历被管理对象的数组
    for (NSManagedObject * oneObject  in objects) {
        int  favoriteNumber = [[oneObject valueForKey:number] intValue];
        
            //        NSString *string =self.dataArray[self.currentRealNum][@"number"];
        if( [[[self.dataArray objectAtIndex:self.currentRealNum] valueForKey:@"randomNumber"] intValue]==favoriteNumber) {
            
            i=1;
        }
        
    }
    if (i==0) {
        theObject =[NSEntityDescription   insertNewObjectForEntityForName:wrong inManagedObjectContext:context];
        [theObject setValue:[NSNumber numberWithInt:[[[self.dataArray objectAtIndex:self.currentRealNum] valueForKey:@"randomNumber"] intValue]] forKey:number];
        
        [appDelegate saveContext];
    }
    
}


-(void)showExplainA
{
    if (self.tag == NO) {
        if (![self.answer isEqualToString:@"A"]) {
             //把错题加入数据库
            [self addTheWrongNum];
            [self.view1 showExplain];
            self.scrollView.contentSize = self.view1.frame.size;
            [self.view1.buttonA setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
            
            CGRect rect = self.view1.frame;
            [self.scrollView scrollRectToVisible:rect animated:YES];
            [self recordAnswerWithAnswer:@"A" forNumber:@(self.currentRealNum)];
        }else{
            [self.view1.buttonA setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
            [self recordAnswerWithAnswer:@"A" forNumber:@(self.currentRealNum)];
        }
        self.tag = YES;
    }
}
-(void)showExplainB
{
  

    if (self.tag == NO) {
        if (![self.answer isEqualToString:@"B"]) {
                //把错题加入数据库
            [self addTheWrongNum];
            [self.view1 showExplain];
            self.scrollView.contentSize = self.view1.frame.size;
            [self.view1.buttonB setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
            
            CGRect rect = self.view1.frame;
            
            [self.scrollView scrollRectToVisible:rect animated:YES];
            [self recordAnswerWithAnswer:@"B" forNumber:@(self.currentRealNum)];
            
        }else{
            [self.view1.buttonB setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
            [self recordAnswerWithAnswer:@"B" forNumber:@(self.currentRealNum)];
        }
        self.tag = YES;
    }
    NSLog(@"11");
}
-(void)showExplainC
{
    if (self.tag == NO) {
        if (![self.answer isEqualToString:@"C"]) {
             //把错题加入数据库
            [self.view1 showExplain];
            self.scrollView.contentSize = self.view1.frame.size;
            [self.view1.buttonC setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
            
            
            CGRect rect = self.view1.frame;
            
            [self.scrollView scrollRectToVisible:rect animated:YES];
            [self recordAnswerWithAnswer:@"C" forNumber:@(self.currentRealNum)];
        }else{
            [self.view1.buttonC setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
            [self recordAnswerWithAnswer:@"C" forNumber:@(self.currentRealNum)];
        }
        self.tag = YES;
    }
}
-(void)showExplainD
{
    
    if (self.tag == NO) {
        if (![self.answer isEqualToString:@"D"]) {
             //把错题加入数据库
            [self.view1 showExplain];
            self.scrollView.contentSize = self.view1.frame.size;
            [self.view1.buttonD setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
            CGRect rect = self.view1.frame;
            
            [self.scrollView scrollRectToVisible:rect animated:YES];
            [self recordAnswerWithAnswer:@"D" forNumber:@(self.currentRealNum)];
        }else{
            [self.view1.buttonD setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
            [self recordAnswerWithAnswer:@"D" forNumber:@(self.currentRealNum)];
        }
        self.tag = YES;
    }
    
}





-(void)loadDataInterfaceWithPlistName:(NSString *)plistName
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:plistName ofType:@"plist"];
    NSArray *dataArray1 = [NSArray arrayWithContentsOfFile:path];
    self.dataArray = [NSMutableArray new];
    if (self.way == commonTest) {
        for (int i= 1; i<=100 ; i++) {
            DataInterface *data = [[DataInterface alloc]init];
            data.randomNumber =arc4random_uniform((int)[dataArray1 count]-1);
            id temp =dataArray1[data.randomNumber];
            data.number = [temp valueForKey:@"number"];
            data.subjectContent = [NSString stringWithFormat:@"%d%c%@",i,'.',[temp valueForKey:@"stem"]] ;
            data.subjectImage = [temp valueForKey:@"image"];
            data.answer = [temp valueForKey:@"answer"];
            data.explain = [temp valueForKey:@"explain"];
            data.alternatives = @[[temp valueForKey:@"A"],[temp valueForKey:@"B"],[temp valueForKey:@"C"],[temp valueForKey:@"D"]];
            [self.dataArray addObject:data];
        }
    }
    if (self.way ==orderTest||self.way ==chapterTest) {
        for (id temp in dataArray1) {
            DataInterface *data = [[DataInterface alloc]init];
            data.number = [temp valueForKey:@"number"];
            data.subjectContent = [temp valueForKey:@"stem"];
            data.subjectImage = [temp valueForKey:@"image"];
            data.answer = [temp valueForKey:@"answer"];
            data.explain = [temp valueForKey:@"explain"];
            data.alternatives = @[[temp valueForKey:@"A"],[temp valueForKey:@"B"],[temp valueForKey:@"C"],[temp valueForKey:@"D"]];
            
            [self.dataArray addObject:data];
        }
    }
    if (self.way == randomTest) {
        for (int i= 1; i<=[dataArray1 count]; i++) {
            DataInterface *data = [[DataInterface alloc]init];
            data.randomNumber =arc4random_uniform((int)[dataArray1 count]);
            id temp =dataArray1[data.randomNumber];
            data.number = [temp valueForKey:@"number"];
            data.subjectContent = [temp valueForKey:@"stem"];
            data.subjectImage = [temp valueForKey:@"image"];
            data.answer = [temp valueForKey:@"answer"];
            data.explain = [temp valueForKey:@"explain"];
            data.alternatives = @[[temp valueForKey:@"A"],[temp valueForKey:@"B"],[temp valueForKey:@"C"],[temp valueForKey:@"D"]];
            [self.dataArray addObject:data];
        }
    }
    if (self.way == strengthTest) {
        AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
        
        NSManagedObjectContext * context = [appDelegate manageObjectContext];
            //搜索准则
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:wrong];
        
        
        NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:number ascending:YES];
        request.sortDescriptors =[NSArray arrayWithObject:sort];
        
        
        NSError * error;
            //根据查询要求返回数组
        
        NSArray * objects = [context executeFetchRequest:request error:&error];
        
        if (objects == nil) {
            NSLog(@"查询结果为空");
        }

        
            //遍历被管理对象的数组
        for (NSManagedObject * oneObject  in objects) {
            int  wrongNumber = [[oneObject valueForKey:number] intValue];
            
                //        NSString *string =self.dataArray[self.currentRealNum][@"number"];
            DataInterface *data = [[DataInterface alloc]init];
            data.randomNumber =wrongNumber;
            id temp =dataArray1[data.randomNumber];
            data.number = [temp valueForKey:@"number"];
            data.subjectContent = [NSString stringWithFormat:@"%d.%@",wrongNumber,[temp valueForKey:@"stem"]];
            data.subjectImage = [temp valueForKey:@"image"];
            data.answer = [temp valueForKey:@"answer"];
            data.explain = [temp valueForKey:@"explain"];
            data.alternatives = @[[temp valueForKey:@"A"],[temp valueForKey:@"B"],[temp valueForKey:@"C"],[temp valueForKey:@"D"]];
            [self.dataArray addObject:data];
            
        }

    }
    
    
}
- (IBAction)button:(UIButton *)sender {
    if (self.currentRealNum < [self.dataArray count]-1) {
            //删除所有视图
        for (id temp in [self.scrollView subviews]) {
            [temp removeFromSuperview];
        }
            //
        NSLog(@"%d",self.currentRealNum);
        self.currentRealNum = self.currentRealNum + 1;
        self.view1 = [[TestView alloc]init];
            //加载数据
        //[self loadDataInterfaceWithPlistName:@"question"];
        DataInterface *data = [DataInterface new];
        data = self.dataArray[self.currentRealNum];
        self.answer = data.answer;
        [self.view1 createMultipleChoiceQuestionWithSubjectContent:data.subjectContent subjectImage:data.subjectImage alternatives:data.alternatives answer:data.answer explain:data.explain];
        
        
        if (self.tag == YES && self.record.count>0 && self.record.count-self.currentRealNum >=1){
            if(self.record[self.currentRealNum] != nil) {
                self.tag = YES;
                NSString *answer = [self.record[self.currentRealNum] objectForKey:@(self.currentRealNum)];
                if ([answer isEqualToString:data.answer]) {
                    if ([answer isEqualToString:@"A"]) {
                        [self.view1.buttonA setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                    }else if ([answer isEqualToString:@"B"]){
                        [self.view1.buttonB setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                    }else if ([answer isEqualToString:@"C"]){
                        [self.view1.buttonC setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                    }else{
                        [self.view1.buttonD setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                    }
                }else{
                    if ([answer isEqualToString:@"A"]) {
                        [self.view1 showExplain];
                        self.scrollView.contentSize = self.view1.frame.size;
                        [self.view1.buttonA setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                        CGRect rect = self.view1.frame;
                        [self.scrollView scrollRectToVisible:rect animated:YES];
                    }else if ([answer isEqualToString:@"B"]){
                        [self.view1 showExplain];
                        self.scrollView.contentSize = self.view1.frame.size;
                        [self.view1.buttonB setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                        CGRect rect = self.view1.frame;
                        [self.scrollView scrollRectToVisible:rect animated:YES];
                    }else if ([answer isEqualToString:@"C"]){
                        [self.view1 showExplain];
                        self.scrollView.contentSize = self.view1.frame.size;
                        [self.view1.buttonC setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                        CGRect rect = self.view1.frame;
                        [self.scrollView scrollRectToVisible:rect animated:YES];
                    }else if ([answer isEqualToString:@"D"]){
                        [self.view1 showExplain];
                        self.scrollView.contentSize = self.view1.frame.size;
                        [self.view1.buttonD setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                        CGRect rect = self.view1.frame;
                        [self.scrollView scrollRectToVisible:rect animated:YES];
                    }
                }
            }else{
                self.tag = NO;
                self.scrollView.contentSize = self.view1.frame.size;
            }
            
        }else{
            self.tag = NO;
            self.scrollView.contentSize = self.view1.frame.size;
        }
        [self.scrollView addSubview:self.view1];
        self.scrollView.backgroundColor = [UIColor clearColor];
        [self buttonAddTatget];
    }
    
}
- (IBAction)button1:(UIButton *)sender {
    if (self.currentRealNum >= 1) {
        for (id temp in [self.scrollView subviews]) {
            [temp removeFromSuperview];
        }
        NSLog(@"%d",self.currentRealNum);
        self.currentRealNum = self.currentRealNum - 1;
        self.view1 = [[TestView alloc]init];
       // [self loadDataInterfaceWithPlistName:@"question"];
        DataInterface *data = [DataInterface new];
        data = self.dataArray[self.currentRealNum];
        self.answer = data.answer;
        [self.view1 createMultipleChoiceQuestionWithSubjectContent:data.subjectContent subjectImage:data.subjectImage alternatives:data.alternatives answer:data.answer explain:data.explain];
        
        if (self.currentRealNum  < self.record.count && self.record.count > 0 && self.record[self.currentRealNum ] != nil) {
            self.tag = YES;
            NSString *answer = [self.record[self.currentRealNum] objectForKey:@(self.currentRealNum)];
            if ([answer isEqualToString:data.answer]) {
                if ([answer isEqualToString:@"A"]) {
                    [self.view1.buttonA setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                }else if ([answer isEqualToString:@"B"]){
                    [self.view1.buttonB setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                }else if ([answer isEqualToString:@"C"]){
                    [self.view1.buttonC setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                }else{
                    [self.view1.buttonD setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                }
            }else{
                if ([answer isEqualToString:@"A"]) {
                    [self.view1 showExplain];
                    self.scrollView.contentSize = self.view1.frame.size;
                    [self.view1.buttonA setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                    CGRect rect = self.view1.frame;
                    [self.scrollView scrollRectToVisible:rect animated:YES];
                }else if ([answer isEqualToString:@"B"]){
                    [self.view1 showExplain];
                    self.scrollView.contentSize = self.view1.frame.size;
                    [self.view1.buttonB setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                    CGRect rect = self.view1.frame;
                    [self.scrollView scrollRectToVisible:rect animated:YES];
                }else if ([answer isEqualToString:@"C"]){
                    [self.view1 showExplain];
                    self.scrollView.contentSize = self.view1.frame.size;
                    [self.view1.buttonC setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                    CGRect rect = self.view1.frame;
                    [self.scrollView scrollRectToVisible:rect animated:YES];
                }else if ([answer isEqualToString:@"D"]){
                    [self.view1 showExplain];
                    self.scrollView.contentSize = self.view1.frame.size;
                    [self.view1.buttonD setBackgroundImage:[UIImage imageNamed:@"roung"] forState:UIControlStateNormal];
                    CGRect rect = self.view1.frame;
                    [self.scrollView scrollRectToVisible:rect animated:YES];
                }
            }
        }else{
            self.tag = NO;
            self.scrollView.contentSize = self.view1.frame.size;
        }
        [self.scrollView addSubview:self.view1];
        self.scrollView.backgroundColor = [UIColor clearColor];
        [self buttonAddTatget];
    }
}
- (IBAction)showAnswer:(id)sender {
    [self.view1 showExplain];
    NSLog(@"1");
    self.scrollView.contentSize = self.view1.frame.size;
    CGRect rect = self.view1.frame;
    [self.scrollView updateConstraints];
    [self.scrollView scrollRectToVisible:rect animated:YES];
}


- (IBAction)putInToFavorite:(id)sender {
    
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext * context = [appDelegate manageObjectContext];
        //搜索准则
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:favorite];
    
    NSError * error;
    int i=0;
        //根据查询要求返回数组
    
    NSArray * objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"查询结果为空");
    }
    NSManagedObject *theObject;
    
        //遍历被管理对象的数组
    for (NSManagedObject * oneObject  in objects) {
        int  favoriteNumber = [[oneObject valueForKey:number] intValue];
        
//        NSString *string =self.dataArray[self.currentRealNum][@"number"];
        NSLog(@"%@",[self.dataArray objectAtIndex:self.currentRealNum]) ;
        if( [[[self.dataArray objectAtIndex:self.currentRealNum] valueForKey:@"randomNumber"] intValue]==favoriteNumber) {
            
             i=1;
        }
        
    }
    if (i==0) {
        theObject =[NSEntityDescription   insertNewObjectForEntityForName:favorite inManagedObjectContext:context];
        [theObject setValue:[NSNumber numberWithInt:[[[self.dataArray objectAtIndex:self.currentRealNum] valueForKey:@"randomNumber"] intValue]] forKey:number];
        
        [appDelegate saveContext];
    }
    
}



-(void)recordAnswerWithAnswer:(NSString *)answer forNumber:(NSNumber *)number
{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:answer forKey:number];
    [self.record addObject:dict];
    if ([answer isEqualToString:self.answer]) {
        self.score+=1;
    }

}
- (IBAction)endTheTest:(id)sender {
    if(self.way ==commonTest){
    self.alert1 =[[UIAlertView alloc]initWithTitle:@"警告" message:@"确认要交卷么？" delegate:self cancelButtonTitle:@"确认交卷" otherButtonTitles:@"取消交卷", nil];
    [self.alert1 show];
        
    }else{
    UITabBarController *tab =[self.storyboard instantiateViewControllerWithIdentifier:@"tab"];
    [self presentViewController:tab animated:YES completion:nil];
    }
//    NSString *theScore =[NSString stringWithFormat:@"您所得的总分为%d",self.score];
//    UIAlertView *alertView =[UIAlertView alloc]initWithTitle:@"答题结果" message:theScore delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:ni, nil
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView ==self.alert1) {
            //选择确认交卷
        if (buttonIndex==0) {
            NSString *theScore =[NSString stringWithFormat:@"您所得的总分为%d",self.score];
            NSString *theEnd;
            if (self.score>=90) {
                theEnd =[NSString stringWithFormat:@",恭喜您，及格"];
            }else {
                theEnd =[NSString stringWithFormat:@",您还要在补习一下,不及格"];
            }
            theScore= [theScore stringByAppendingString:theEnd];
            self.alert2 =[[UIAlertView alloc]initWithTitle:@"总得分" message:theScore delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [self.alert2 show];
        }
        
    
            //将考试成绩放入数据库
        AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
        
        NSManagedObjectContext * context = [appDelegate manageObjectContext];
            //搜索准则
        NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:paper];
        
        NSError * error;
        
            //获取当前的时间
        NSDate *date = [NSDate date];
        /*下面方法返回当前时间再加上10秒后的时间*/
            //    date = [NSDate dateWithTimeIntervalSinceNow:60];
            //    NSLog(@"date=%@",date);
        
        /*获取北京时区*/
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        /*获取本地时区跟GMT时区相差多少秒*/
        NSInteger interval = [zone secondsFromGMTForDate:date];
        NSDate *local = [NSDate dateWithTimeIntervalSinceNow:interval];
        
            //根据查询要求返回数组
        
        NSArray * objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"查询结果为空");
        }
        NSManagedObject * theObject;
        
        theObject =[NSEntityDescription   insertNewObjectForEntityForName:paper inManagedObjectContext:context];
        [theObject setValue:[NSNumber numberWithInt:self.score] forKey:score];
        [theObject setValue:local forKey:@"date"];
            [appDelegate saveContext];
    }
    
    
    
    if (alertView == self.alert2||alertView ==self.alert3) {
        if (buttonIndex==0) {
             UITabBarController *tab =[self.storyboard instantiateViewControllerWithIdentifier:@"tab"];
            [self presentViewController:tab animated:YES completion:nil];
        }
    }
    
    
}




@end
