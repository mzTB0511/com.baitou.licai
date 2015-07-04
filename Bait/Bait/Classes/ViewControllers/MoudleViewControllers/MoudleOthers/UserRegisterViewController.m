//
//  UserRegisterViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UserRegisterPwdViewController.h"


@interface UserRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_userPhone;


@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewTitle:@"注册"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"push_to_registerPwdView"]) {
        
        UserRegisterPwdViewController *viewContorler  = (UserRegisterPwdViewController *)segue.destinationViewController;

        viewContorler.userPhone = _tf_userPhone.text;
        
    }
    
    
}



-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    // 跳转注册页面
    if ([identifier isEqualToString:@"push_to_registerPwdView"]) {
        
    //** 验证手机号是否有效
        if (![[CommonFunc shareInstance] isValidatePhone:_tf_userPhone.text]) {
            [CommonHUD showHudWithMessage:@"请输入正确的手机号" delay:1.5f completion:nil];
            return NO;
        }
        
        return YES;
    }
    
    
    return  YES;
    
}



@end
