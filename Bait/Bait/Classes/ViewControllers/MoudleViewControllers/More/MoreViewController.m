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
#import "UserCenterUserInfoViewController.h"
#import "BaseNavigationViewController.h"
#import <UIView+BlocksKit.h>
#import "UserLoginViewController.h"
#import <UIButton+WebCache.h>

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


//** View 添加点击事件
@property(strong,nonatomic) UITapGestureRecognizer *tapRecognizer;


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewTitle:@"更多"];
    
    [self action_RefrashView];
    
  //   [self.btn_Login setHidden:NO];
    
}


//**通知方法，登录，注册成功后刷新当前页面
-(void)action_RefrashView{
    
        //** 判断用户当前是否是已经登录状态
        if ([CommonUser ifUserHasLogin]) {
            [self.v_UserIcoPhone setHidden:NO];
            [self.btn_Login setHidden:YES];
    
            NSRange range = NSMakeRange(4, 4);
            
            NSString *rangePhone = [[CommonUser userPhone] stringByReplacingCharactersInRange:range  withString:@"****"];
            
            [self.lb_UserPhone setText:rangePhone];
            
            WEAKSELF
            [_v_UserIcoPhone bk_whenTapped:^{
               
                [weakSelf userIcoPhoneTapEvent];
            }];
            
    
        }else{
            [self.btn_Login setHidden:NO];
            [self.v_UserIcoPhone setHidden:YES];
            
            [self.lb_UserPhone setText:[CommonUser userPhone]];
            [self.btn_UseIco sd_setImageWithURL:getUrlWithStrValue([CommonUser userInfo].user_ico) forState:UIControlStateNormal placeholderImage:default_Image_UserIco];
        }
    
}




-(void)userIcoPhoneTapEvent{
    
    pushViewControllerWith(sbStoryBoard_Moudle_UserCenter, UserCenterUserInfoViewController, nil);
    
}



- (IBAction)action_Login:(id)sender {
    
    
    UserLoginViewController *loginView = getViewControllFromStoryBoard(sbStoryBoard_Moudle_LoginRegister, UserLoginViewController);
    
    BaseNavigationViewController *nav_Base = [[BaseNavigationViewController alloc] initWithRootViewController:loginView];
    [nav_Base awakeFromNib];
    WEAKSELF
    loginView.actionLoginBlock = ^(){
      
        [weakSelf dismissViewControllerAnimated:YES completion:^{
             [weakSelf action_RefrashView];
        }];
        
    };
    
    
    [self presentViewController:nav_Base animated:YES completion:nil];
    
    
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




- (IBAction)action_CallPhone:(id)sender {
    
    [UIAlertView showAlertViewWithTitle:@"提示" message:@"400-888-8888" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex) {
       
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://40088888888"]];
    } onCancel:^{
        
    }];
    
    
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