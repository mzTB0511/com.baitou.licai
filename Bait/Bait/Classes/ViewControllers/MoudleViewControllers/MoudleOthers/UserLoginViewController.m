//
//  UserLoginViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "UserLoginViewController.h"
#import "NetworkHandle.h"
#import <NSString+MD5.h>

@interface UserLoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *tf_UserPhone;

@property (weak, nonatomic) IBOutlet UITextField *tf_UserPwd;


@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewTitle:@"登录"];
    
    [self customerLeftNavigationBarItemWithTitle:@"返回" andImageRes:nil];
    
}

-(void)backToView{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)actionLogin:(id)sender {
    
    [self.view endEditing:YES];
    
    if (![CommonIO validateMobile:_tf_UserPhone.text]) {
        [CommonHUD showHudWithMessage:@"手机号不正确" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
    if ([_tf_UserPwd.text isEqualToString:@""]) {
        [CommonHUD showHudWithMessage:@"请输入密码" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
    NSDictionary *data = @{@"phone":_tf_UserPhone.text,
                           @"pwd":[_tf_UserPwd.text MD5Digest]};
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/login")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              [CommonUser userLoginSuccess:responseDictionary block:^{
                                                
                                                  [weakSelf backToView];
                                                  
                                                  [mNotificationCenter postNotificationName:Com_Notifation_MoreViewController object:nil];
                                                  
                                              }];
                                          }
                                          failure:nil
                                   networkFailure:nil];
    
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
