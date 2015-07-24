//
//  MP4ViewController1.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/25.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MP4ViewController : UIViewController
{
    MPMoviePlayerViewController *moviePlayer;
}
@property (strong,nonatomic) NSString *url;

@end
