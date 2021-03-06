//
//  UserRegisterPwdViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "UserRegisterPwdViewController.h"
#import "NetworkHandle.h"
#import "UIButton+Verify.h"
#import "UserRegisterSetPwdViewController.h"

@interface UserRegisterPwdViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lb_UserPhone;

@property (weak, nonatomic) IBOutlet UITextField *tf_VertifyCode;


@property (weak, nonatomic) IBOutlet UIButton *btn_SendCode;




@end

@implementation UserRegisterPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewTitle:@"注册"];
    
   // [self customerLeftNavigationBarItemWithTitle:@"返回" andImageRes:nil];
    
    
    [_lb_UserPhone setText:_userPhone];
    
    
    [self action_sendVerify:_btn_SendCode];
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return YES;
    }
    
    if (textField == _tf_VertifyCode && textField.text.length >= 4 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9'))//数据格式正确
        {
            return YES;
        }else{
            return NO;
        }
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



/**
 *  验证验证码是否正确
 *
 *
 */
-(IBAction)action_CheckVerifyCode{
    
    
    if (_tf_VertifyCode.text.length != 4) {
        [CommonHUD showHudWithMessage:@"请输入四位验证码" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
    WEAKSELF
    //验证验证码
    [NetworkHandle loadDataFromServerWithParamDic:@{@"vertify_code":_tf_VertifyCode.text}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/verifycodecheck")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              //** 验证码通过跳转到设置密码页面
                                              [weakSelf pushToRegisterSetPwdViewController];
                                          }
                                          failure:nil
                                   networkFailure:nil];
    
    
}



-(void)pushToRegisterSetPwdViewController{
    
    pushViewControllerWith(sbStoryBoard_Moudle_LoginRegister, UserRegisterSetPwdViewController,_lb_UserPhone.text);
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
