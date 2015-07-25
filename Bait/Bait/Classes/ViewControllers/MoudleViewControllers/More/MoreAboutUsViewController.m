//
//  MoreAboutUsViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoreAboutUsViewController.h"

@interface MoreAboutUsViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *web_WebView;



@end

@implementation MoreAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self setViewTitle:@"关于我们"];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    NSString *memberID = [CommonUser userID];
    NSString *udid = [CommonUser udid];
    NSString *platformID = @"1";
    NSString *version = [CommonIO appVersion];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://101.231.74.38/baitou/app/tools/aboutus?member_id=%@&ud_id=%@&version=%@&platform_id=%@",memberID,udid,version,platformID];
    
    [_web_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
}


#pragma mark -- UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [CommonHUD showHud];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [CommonHUD hideHud];
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
