//
//  MP4ViewController1.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/25.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "MP4ViewController.h"
#import "SecondViewController.h"


@interface MP4ViewController ()

@end

@implementation MP4ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
        //初始化播放器和播放模式
    moviePlayer =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:self.url ofType:@"mp4"]]];
        //控制播放类型为全屏
    moviePlayer.moviePlayer.controlStyle =MPMovieControlStyleFullscreen;
        //控制模式触摸
    moviePlayer.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:moviePlayer.view];
    [moviePlayer.moviePlayer play];
    
    [self shouldAutorotate];
    [self supportedInterfaceOrientations];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myMovieFinishedCallBack:) name:MPMoviePlayerPlaybackDidFinishNotification   object:moviePlayer.moviePlayer];
    
        // Do any additional setup after loading the view.
}


-(void)myMovieFinishedCallBack:(NSNotification *)notify
{
//    SecondViewController *view =[self.storyboard instantiateViewControllerWithIdentifier:@"second"];
    [moviePlayer.view removeFromSuperview];
    [[self navigationController]popViewControllerAnimated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
