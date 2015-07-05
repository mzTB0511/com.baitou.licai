//
//  EditPhoneVeriferPwdViewController.m
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "EditPhoneVeriferPwdViewController.h"
#import "NetworkHandle.h"
#import <NSString+MD5.h>
#import "EditPhoneNewPhoneViewController.h"


@interface EditPhoneVeriferPwdViewController ()


@property (weak, nonatomic) IBOutlet UITextField *tf_UserPwd;


@end

@implementation EditPhoneVeriferPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setViewTitle:@"验证身份"];
}



- (IBAction)action_Next:(id)sender {
   
    [self.view endEditing:YES];
    //** 验证用户密码是否正确
    NSDictionary *data = @{@"phone":[CommonUser userPhone],
                           @"old_pwd":[_tf_UserPwd.text MD5Digest],
                           @"step":@"1"};
    
    
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/resetphone")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              pushViewControllerWith(sbStoryBoard_Moudle_UserCenter, EditPhoneNewPhoneViewController, nil);
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
     showLoading:YES];

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
