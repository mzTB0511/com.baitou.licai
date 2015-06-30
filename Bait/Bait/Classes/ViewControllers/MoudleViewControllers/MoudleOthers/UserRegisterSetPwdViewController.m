//
//  UserRegisterSetPwdViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "UserRegisterSetPwdViewController.h"
#import "NetworkHandle.h"

@interface UserRegisterSetPwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_UserPwd;


@property (weak, nonatomic) IBOutlet UITextField *tf_CheckUsePwd;

@property(nonatomic,strong) NSString *userPhone;


@end

@implementation UserRegisterSetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTitle:@"完善密码"];
    
    [self customerLeftNavigationBarItemWithTitle:@"返回" andImageRes:nil];
    
    _userPhone = (self.viewObject) ? ((NSString *)self.viewObject) : @"";
    
    
}



/**
 *  登录
 */
- (IBAction)actionRegister{
    
    [self.view endEditing:YES];
    
    if (![_tf_UserPwd.text isEqualToString:@""]) {
        [CommonHUD showHudWithMessage:@"请输入密码" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
    if (![_tf_CheckUsePwd.text isEqualToString:_tf_UserPwd.text]) {
        [CommonHUD showHudWithMessage:@"密码不一致" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
    [self actionRegisterWithData:@{@"phone":_userPhone,
                                 @"pwd":_tf_UserPwd.text}];
}

- (void) actionRegisterWithData:(NSDictionary *)data {
    
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/register")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              [CommonUser userLoginSuccess:responseDictionary block:nil];
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
