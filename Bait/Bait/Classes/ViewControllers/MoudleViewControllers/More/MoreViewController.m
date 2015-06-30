//
//  MoreViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreAboutUsViewController.h"
#import "MoreCustomerServiceViewController.h"
#import "MoreFadebackViewController.h"
#import "MoreNormalIssueViewController.h"



@interface MoreViewController ()

//**头像，手机号视图
@property (weak, nonatomic) IBOutlet UIView *v_UserIcoPhone;

@property (weak, nonatomic) IBOutlet UIButton *btn_UseIco;

@property (weak, nonatomic) IBOutlet UILabel *lb_UserPhone;

//**登录按钮
@property (weak, nonatomic) IBOutlet UIButton *btn_Login;


@property (weak, nonatomic) IBOutlet UIButton *btn_InvateOthers;


@property (weak, nonatomic) IBOutlet UIButton *btn_Fadebacek;


@property (weak, nonatomic) IBOutlet UIButton *btn_Service;


@property (weak, nonatomic) IBOutlet UIButton *btn_Issure;


@property (weak, nonatomic) IBOutlet UIButton *btn_AboutUs;





@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewTitle:@"更多"];
}



- (IBAction)action_InvateOthers:(id)sender {
    
    pushViewControllerWith(sbStoryBoard_Moudle_More, MoreAboutUsViewController, nil);
}



- (IBAction)action_Fadeback:(id)sender {
     pushViewControllerWith(sbStoryBoard_Moudle_More, MoreFadebackViewController, nil);
}



- (IBAction)action_Service:(id)sender {
     pushViewControllerWith(sbStoryBoard_Moudle_More, MoreCustomerServiceViewController, nil);
}




- (IBAction)action_Issure:(id)sender {
     pushViewControllerWith(sbStoryBoard_Moudle_More, MoreNormalIssueViewController, nil);
}



- (IBAction)action_AboutUs:(id)sender {
     pushViewControllerWith(sbStoryBoard_Moudle_More, MoreAboutUsViewController, nil);
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
