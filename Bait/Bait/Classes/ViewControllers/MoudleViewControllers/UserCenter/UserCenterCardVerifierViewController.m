//
//  UserCenterCardVerifierViewController.m
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "UserCenterCardVerifierViewController.h"
#import "NetworkHandle.h"


@interface UserCenterCardVerifierViewController ()


@property (weak, nonatomic) IBOutlet UITextField *tf_UserName;


@property (weak, nonatomic) IBOutlet UITextField *tf_Card;


@end

@implementation UserCenterCardVerifierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setViewTitle:@"身份认证"];
}



-(BOOL)checkData{
    
    if ([_tf_UserName.text isEqualToString:@""]) {
        [CommonHUD showHudWithMessage:@"请输入真实姓名" delay:CommonHudShowDuration completion:nil];
        return NO;
    }
    
    if ([_tf_Card.text isEqualToString:@""]) {
        [CommonHUD showHudWithMessage:@"请输入身份证号" delay:CommonHudShowDuration completion:nil];
        return NO;
    }
    
    
    return YES;
    
}


- (IBAction)action_VerifierCard:(id)sender {
    
    if (![self checkData]) {
        return;
    }
    
    [self.view endEditing:YES];
    //** 验证用户密码是否正确
    NSDictionary *data = @{@"member_name":_tf_UserName.text,
                           @"card_no":_tf_Card.text};
    
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/verifiercard")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              
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
