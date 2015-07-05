//
//  EidtPhoneNewPwdViewController.m
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "EditPhoneNewPwdViewController.h"
#import "NetworkHandle.h"
#import <NSString+MD5.h>

@interface EditPhoneNewPwdViewController ()


@property (weak, nonatomic) IBOutlet UITextField *tf_OldPwd;

@property (weak, nonatomic) IBOutlet UITextField *tf_NewPwd;

@property (weak, nonatomic) IBOutlet UITextField *tf_CheckPwd;

@property(strong, nonatomic) NSDictionary *passDict;



@end

@implementation EditPhoneNewPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setViewTitle:@"更换手机号"];
    
    if (self.viewObject) {
        _passDict = (NSDictionary *)self.viewObject;
    }
    
    
}


-(BOOL)checkData{
    
    if ([_tf_OldPwd.text isEqualToString:@""]) {
        [CommonHUD showHudWithMessage:@"请输入原密码" delay:CommonHudShowDuration completion:nil];
        return NO;
    }
    
    if (![_tf_NewPwd.text isEqualToString:_tf_CheckPwd.text]) {
        [CommonHUD showHudWithMessage:@"输入的密码不一致" delay:CommonHudShowDuration completion:nil];
        return NO;
    }

    
    return YES;
    
}



- (IBAction)action_Complate:(id)sender {
    
    if (![self checkData]) {
        return;
    }
    
    [self.view endEditing:YES];
    //** 验证用户密码是否正确
    NSDictionary *data = @{@"phone":[CommonUser userPhone],
                           @"pwd":[_tf_OldPwd.text MD5Digest],
                           @"new_pwd":[_tf_NewPwd.text MD5Digest],
                           @"type":@"2"};
    
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/resetpwd")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              [self.navigationController popToRootViewControllerAnimated:YES];
                                              
                                              [mNotificationCenter postNotificationName:Com_Notifation_MoreViewController object:nil];
                                          }
                                          failure:nil
                                   networkFailure:nil
     
     ];
     
    
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
