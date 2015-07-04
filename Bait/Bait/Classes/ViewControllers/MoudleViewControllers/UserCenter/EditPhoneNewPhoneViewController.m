//
//  EditPhoneNewPhoneViewController.m
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "EditPhoneNewPhoneViewController.h"
#import "UIButton+Verify.h"
#import "EditPhoneNewPwdViewController.h"

#import "NetworkHandle.h"
@interface EditPhoneNewPhoneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lb_UserPhone;


@property (weak, nonatomic) IBOutlet UITextField *tf_VerifierCode;

@property (weak, nonatomic) IBOutlet UITextField *tf_NewPhone;

@property (weak, nonatomic) IBOutlet UITextField *tf_CheckNewPhone;




@end

@implementation EditPhoneNewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setViewTitle:@"更换手机号"];
    
    [_lb_UserPhone setText:[CommonUser userPhone]];
    
}



-(BOOL)checkData{
    
    if ([_tf_VerifierCode.text isEqualToString:@""]) {
        [CommonHUD showHudWithMessage:@"请输入验证码" delay:CommonHudShowDuration completion:nil];
        return NO;
    }
    
    if (![_tf_NewPhone.text isEqualToString:_tf_CheckNewPhone.text]) {
        [CommonHUD showHudWithMessage:@"输入的手机号不一致" delay:CommonHudShowDuration completion:nil];
        return NO;
    }
    
    
    return YES;
    
}


/**
 *  发送验证码
 */
- (IBAction)action_sendVerify:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (![CommonIO validateMobile:_lb_UserPhone.text]) {
        [CommonHUD showHudWithMessage:@"手机号不正确" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
    [sender unavailable];
    
    //发送验证码
    [NetworkHandle loadDataFromServerWithParamDic:@{@"phone":_lb_UserPhone.text}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/verifycode")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              [CommonHUD showHudWithMessage:@"发送成功" delay:CommonHudShowDuration completion:nil];
                                          }
                                          failure:nil
                                   networkFailure:nil];
}






- (IBAction)action_GoOn:(id)sender {
    
    [self.view endEditing:YES];
    //** 验证用户密码是否正确
    NSDictionary *data = @{@"phone":[CommonUser userPhone],
                           @"verify_code":_tf_VerifierCode.text,
                           @"new_phone":_tf_NewPhone.text,
                           @"step":@"1"};
    
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/resetphone")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              //**返回跟视图 刷新页面信息
                                              [CommonUser resetUserPhone:_tf_NewPhone.text];
                                              
                                              [self.navigationController popToRootViewControllerAnimated:YES];
                                              
                                               [mNotificationCenter postNotificationName:Com_Notifation_MoreViewController object:nil];
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
                                      showLoading:YES];
    
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
