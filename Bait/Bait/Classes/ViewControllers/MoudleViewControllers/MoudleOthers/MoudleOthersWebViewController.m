//
//  MoudleOthersWebViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoudleOthersWebViewController.h"
#import "NetworkHandle.h"

@interface MoudleOthersWebViewController ()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *wb_WebView;

@end

@implementation MoudleOthersWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([self.viewObject isKindOfClass:[NSDictionary class]]) {
        
        //健康提醒
        //健康提醒
        NSString *userID = [CommonUser userID];
        NSString *UDID = [CommonUser udid];
        NSString *app_Version = [CommonIO appVersion];
        NSString *productID = @"16";
        
        NSDictionary *postDict = [NetworkHandle makePostParamsWithParamDic:nil AndSignDict:nil];
        NSString *signature = [postDict objectForKey:App_Sign];
        
        NSString *url =[NSString stringWithFormat:@"%@?productID=%@&userID=%@&platformID=%@&version=%@&signature=%@&udid=%@",InterfaceAddressName(@"store/htmlshow"),productID,userID,@"1",app_Version,signature,UDID];
        
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_wb_WebView loadRequest:request];
    }
    
}



#pragma mark --  UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [CommonHUD showHud];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
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
