//
//  FirstViewController.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/2.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "FirstViewController.h"
#import  "autoButton.h"
#import "FirstDetail.h"
#import "TestViewTController.h" 
#import  "ShowTableViewController.h"



@interface FirstViewController ()

@property (strong, nonatomic)  autoButton *buttonZhongXin;
@property (strong, nonatomic)  autoButton *buttonOrder;
@property (strong, nonatomic)  autoButton *buttonChapters;
@property (strong, nonatomic)  autoButton *buttonStrengthen;
@property (strong, nonatomic)  autoButton *buttonRandom;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpCenter;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpRight;
@property (assign,nonatomic) CGRect frame;
@property (strong,nonatomic) NSDictionary *dict;
@property (strong,nonatomic) UIAlertView *alertViewZhongXin;
@property (strong,nonatomic) UIAlertView *alertViewOrder;
@property (strong,nonatomic) UIAlertView *alertViewChapters;
@property (strong,nonatomic) UIAlertView *alertViewStrengthen;
@property (strong,nonatomic) UIAlertView *alertViewRandom;



@property int  way;
@end

@implementation FirstViewController
-(void)viewWillAppear:(BOOL)animated
{
        //取出数据
    NSBundle *bundle =[NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"knowList" ofType:@"plist"];
    NSDictionary *dict =[[NSDictionary alloc]initWithContentsOfFile:plistpath];
    
    self.dict =dict;
    
    
    
        //将其他的图标放在屏幕中
        //顺序图标
    UIImage *image2 =[UIImage imageNamed:@"顺序练习"];
    self.frame = CGRectMake(140, 275, 80, 80);
    self.buttonOrder =[[autoButton alloc]initWithImage:image2 andFrame:self.frame];
    [self.view addSubview:self.buttonOrder];
    self.frame =self.buttonOrder.frame;
    
    
    
    
    
    
    
    
        //章节图标放在屏幕中
    UIImage *image3 =[UIImage imageNamed:@"章节练习"];
    self.buttonChapters =[[autoButton alloc]initWithImage:image3 andFrame:self.frame];
    [self.view addSubview:self.buttonChapters];
    
    
    
        //强化图标
    UIImage *image4 =[UIImage imageNamed:@"强化练习"];
    self.buttonStrengthen =[[autoButton alloc]initWithImage:image4 andFrame:self.frame];
    [self.view addSubview:self.buttonStrengthen];
    
    
        //随机图标
    UIImage *image5 =[UIImage imageNamed:@"随机练习"];
    self.buttonRandom =[[autoButton alloc]initWithImage:image5 andFrame:self.frame];
    [self.view addSubview:self.buttonRandom];
    
    
    
        //将事件触发放入viewController中
    
    [self.buttonChapters addTarget:self action:@selector(touchDownButtonChapters) forControlEvents:UIControlEventTouchDown];
    [self.buttonChapters addTarget:self action:@selector(buttonChaptersPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonOrder addTarget:self action:@selector(touchDownButtonOrder) forControlEvents:UIControlEventTouchDown];
    [self.buttonOrder addTarget:self action:@selector(buttonOrderPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonRandom  addTarget:self action:@selector(touchDownButtonRandom) forControlEvents:UIControlEventTouchDown];
    [self.buttonRandom  addTarget:self action:@selector(buttonRandomPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonStrengthen addTarget:self action:@selector(touchDownButtonStrengthen) forControlEvents:UIControlEventTouchDown];
    [self.buttonStrengthen addTarget:self action:@selector(buttonStrengthPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
        //将中心大图标设置在屏幕中
    UIImage *image1 = [UIImage imageNamed:@"模拟考试"];
    self.frame = CGRectMake(120, 255, 120,120);
    self.buttonZhongXin = [[autoButton alloc]initWithImage:image1 andFrame:self.frame];
    self.buttonZhongXin.titleLabel.text =@"模拟考试";
    
    
        //单独放置中心图标
    [self.view addSubview:self.buttonZhongXin];
    [self.buttonZhongXin addTarget:self action:@selector(touchDownButton) forControlEvents:UIControlEventTouchDown];
    [self.buttonZhongXin addTarget:self action:@selector(buttonZhongXinPressed) forControlEvents:UIControlEventTouchUpInside];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
//     self.frame =self.buttonZhongXin.frame;

    // Do any additional setup after loading the view, typically from a nib.


    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        //

    // Dispose of any resources that can be recreated.
}






    //加载视图时先显示旁边四个按钮的动画
-(void)viewDidAppear:(BOOL)animated
{
    
    [self buttonOrderChanged];
    [self buttonChaptersChanged];
    [self buttonStrengthenChanged];
    [self buttonRandomChanged];
    
}


    //移除视图时消除掉几个按钮
-(void)viewWillDisappear:(BOOL)animated
{
    [self reset];
}


    //移除按钮
-(void)reset
{
    [self.buttonZhongXin removeFromSuperview];
    [self.buttonRandom removeFromSuperview];
    [self.buttonOrder removeFromSuperview];
    [self.buttonChapters removeFromSuperview];
    [self.buttonStrengthen removeFromSuperview];
//    [self buttonOrderDechanged];
//    [self buttonChaptersDechanged];
//    [self buttonStrengthenDechanged];
//    [self buttonRandomDechanged];
}



    //顺序按钮改变时移动位置
-(void)buttonOrderChanged
{
    self.frame =self.buttonOrder.frame;
    [UIButton animateKeyframesWithDuration:0.8f delay:0.0f options:
    UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        
        [self.buttonOrder setFrame:CGRectMake(self.buttonOrder.frame.origin.x-100, self.buttonOrder.frame.origin.y-100, self.frame.size.width, self.frame.size.height)];
    } completion:nil];

}
    //章节练习按钮改变位置
-(void)buttonChaptersChanged
{
    self.frame =self.buttonChapters.frame;
    [UIButton animateKeyframesWithDuration:0.8f delay:0.0f options:
     UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
         
         [self.buttonChapters setFrame:CGRectMake(self.buttonChapters.frame.origin.x+100, self.buttonChapters.frame.origin.y-100, self.frame.size.width, self.frame.size.height)];
     } completion:nil];
    
}
    //强化练习按钮改变位置
-(void)buttonStrengthenChanged
{
    self.frame =self.buttonStrengthen.frame;
    [UIButton animateKeyframesWithDuration:0.8f delay:0.0f options:
     UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
         
         [self.buttonStrengthen setFrame:CGRectMake(self.buttonStrengthen.frame.origin.x-100, self.buttonStrengthen.frame.origin.y+100, self.frame.size.width, self.frame.size.height)];
     } completion:nil];
    
}

    //随机按钮改变位置
-(void)buttonRandomChanged
{
    self.frame =self.buttonRandom.frame;
    [UIButton animateKeyframesWithDuration:0.8f delay:0.0f options:
     UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
         
         [self.buttonRandom setFrame:CGRectMake(self.buttonRandom.frame.origin.x+100, self.buttonRandom.frame.origin.y+100, self.frame.size.width, self.frame.size.height)];
     } completion:nil];
    
}



/*

    //顺序按钮最后回原来的位置

-(void)buttonOrderDechanged
{
 
         
         [self.buttonOrder setFrame:CGRectMake(self.buttonOrder.frame.origin.x+100, self.buttonOrder.frame.origin.y+100, self.frame.size.width, self.frame.size.height)];

    
}

    //章节练习时回到原来的位置
-(void)buttonChaptersDechanged
{
    
    
    [self.buttonChapters setFrame:CGRectMake(self.buttonChapters.frame.origin.x-100, self.buttonChapters.frame.origin.y+100, self.frame.size.width, self.frame.size.height)];
    
    
}
    //强化按钮回到原来的位置
-(void)buttonStrengthenDechanged
{
    
    
    [self.buttonStrengthen setFrame:CGRectMake(self.buttonStrengthen.frame.origin.x+100, self.buttonStrengthen.frame.origin.y-100, self.frame.size.width, self.frame.size.height)];
    
    
}
    //随机按钮回到原来的位置
-(void)buttonRandomDechanged
{
    
    
    [self.buttonRandom setFrame:CGRectMake(self.buttonRandom.frame.origin.x-100, self.buttonRandom.frame.origin.y-100, self.frame.size.width, self.frame.size.height)];
    
    
}
*/
    //中心按钮被点击时触发的动画
-(void)touchDownButton
{
   self.frame =self.buttonZhongXin.frame;
    [UIButton animateKeyframesWithDuration:0.5f delay:0.2f options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        
        [self.buttonZhongXin setFrame:CGRectMake(self.buttonZhongXin.frame.origin.x-10, self.buttonZhongXin.frame.origin.y-10, self.frame.size.width+20, self.frame.size.height+20)];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            
            [self.buttonZhongXin setFrame:self.frame];
        }];
    } completion:nil];
    
}

    //中心按钮被点击后触发警告框，通知是否要进行考试
-(void)buttonZhongXinPressed
{
    self.alertViewZhongXin =[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"马上进入模拟考试环节，请你做好准备，有xxxx分钟，共做题100道，每道题1分" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"不进入", nil];
    [self.alertViewZhongXin show];
}





    //其他按钮被按的时候触发动画
    //按下随机试卷按钮时触发动画
-(void)touchDownButtonRandom
{
    self.frame =self.buttonRandom.frame;
    [UIButton animateKeyframesWithDuration:0.5f delay:0.2f options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        
        [self.buttonRandom setFrame:CGRectMake(self.buttonRandom.frame.origin.x-10, self.buttonRandom.frame.origin.y-10, self.frame.size.width+20, self.frame.size.height+20)];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            
            [self.buttonRandom setFrame:self.frame];
        }];
    } completion:nil];
    
}
-(void)buttonRandomPressed
{
    self.way =randomTest;
    [self methodToTest];
}

-(void)buttonOrderPressed
{
    self.way =orderTest;
    [self methodToTest];
}



    //按下顺序考试按钮时触发动画
-(void)touchDownButtonOrder
{
    self.frame =self.buttonOrder.frame;
    [UIButton animateKeyframesWithDuration:0.5f delay:0.2f options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        
        [self.buttonOrder setFrame:CGRectMake(self.buttonOrder.frame.origin.x-10, self.buttonOrder.frame.origin.y-10, self.frame.size.width+20, self.frame.size.height+20)];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            
            [self.buttonOrder setFrame:self.frame];
        }];
    } completion:nil];
    
}

-(void)buttonChaptersPressed
{
    self.way =chapterTest;
    [self methodToTest];
}

    //按下章节考试按钮时触发动画
-(void)touchDownButtonChapters
{
    self.frame =self.buttonChapters.frame;
    [UIButton animateKeyframesWithDuration:0.5f delay:0.2f options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        
        [self.buttonChapters setFrame:CGRectMake(self.buttonChapters.frame.origin.x-10, self.buttonChapters.frame.origin.y-10, self.frame.size.width+20, self.frame.size.height+20)];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            
            [self.buttonChapters setFrame:self.frame];
        }];
    } completion:nil];
    
}




    //按下强化考试按钮时触发动画
-(void)touchDownButtonStrengthen
{
    self.frame =self.buttonStrengthen.frame;
    [UIButton animateKeyframesWithDuration:0.5f delay:0.2f options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        
        [self.buttonStrengthen setFrame:CGRectMake(self.buttonStrengthen.frame.origin.x-10, self.buttonStrengthen.frame.origin.y-10, self.frame.size.width+20, self.frame.size.height+20)];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            
            [self.buttonStrengthen setFrame:self.frame];
        }];
    } completion:nil];
    
}

-(void)buttonStrengthPressed
{
    self.way =strengthTest;
    [self methodToTest];
}

    //传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSArray *selected;
    NSString *title;
        //判断是哪一个segue
    if([segue.identifier isEqualToString:@"show1"])
        {
            //通过segue的目标视图控制器，获得CitiesTableViewController类的实例
        FirstDetail *firstDetail=segue.destinationViewController;
       
            //表视图选定的行
        title =@"报名须知";
        selected = [self.dict objectForKey:title];
        firstDetail.title =title;
        firstDetail.selected=selected;
        
        }
    else if([segue.identifier isEqualToString:@"show2"])
        {
            //通过segue的目标视图控制器，获得CitiesTableViewController类的实例
        FirstDetail *firstDetail=segue.destinationViewController;
        
            //表视图选定的行
        title =@"交通标志";
        selected = [self.dict objectForKey:title];
        firstDetail.title =title;
        firstDetail.selected=selected;
        }
    else if([segue.identifier isEqualToString:@"show3"]){
        FirstDetail *firstDetail=segue.destinationViewController;
        
            //表视图选定的行
        title =@"技巧法规";
        selected = [self.dict objectForKey:title];
        firstDetail.title =title;
        firstDetail.selected=selected;
    }
    else if([segue.identifier isEqualToString:@"show4"]){
        ShowTableViewController *show =segue.destinationViewController;
        
            //表视图选定的行
        title =@"我的收藏";
        
        show.title =title;
    }
    else if([segue.identifier isEqualToString:@"show6"]){
        ShowTableViewController *show =segue.destinationViewController;
        
            //表视图选定的行
        title =@"我的错题";
        
        show.title =title;
    }else if([segue.identifier isEqualToString:@"show7"]){
        ShowTableViewController *show =segue.destinationViewController;
        
            //表视图选定的行
        title =@"考试记录";
        
        show.title =title;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == self.alertViewZhongXin){
    if (buttonIndex == 0) {
//        NSDictionary *dict =@{@"way":@1};
//        NSNotification  *notification =[NSNotification notificationWithName:@"test" object:self userInfo:dict];
//        [[NSNotificationCenter defaultCenter]postNotification:notification];
        self.way=commonTest;
        
        [self methodToTest];
        
    }
    else if (buttonIndex ==1){
       
    }
    }
    
    
}



    //跳转界面并且传值给下个界面，如何考试
-(void)methodToTest
{
    TestViewTController  *test =[self.storyboard instantiateViewControllerWithIdentifier:@"test"];
    test.way =self.way;
//    [self.navigationController pushViewController:test animated:YES];
    [self presentViewController:test animated:YES completion:nil];
}



@end
