//
//  HTMLView.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/16.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "HTMLView.h"

@interface HTMLView ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HTMLView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath =[[NSBundle mainBundle]pathForResource:self.local ofType:@"html"];
    NSString *htmlString =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString *path =[[NSBundle mainBundle]bundlePath];
//    NSLog(@"%@",path);
    NSURL *baseURL =[NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
//    NSString *imagePath =[filePath stringByAppendingString:@"//img//"];
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:imagePath]];
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

@end
