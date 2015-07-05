//
//  MyPropertyGetCashViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyGetCashViewController.h"
#import "NetworkHandle.h"

@interface MyPropertyGetCashViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *img_VenderIco;


@property (weak, nonatomic) IBOutlet UILabel *lb_CashTotal;


@property (weak, nonatomic) IBOutlet UIButton *btn_CashApply;




@end

@implementation MyPropertyGetCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setViewTitle:@"返利取现"];
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/getRepayAll")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSDictionary *rebateDict = [[responseDictionary objectForKey:Return_data] objectAtIndex:0];
                                                  
                                                  [weakSelf.lb_CashTotal setText:[rebateDict objectForKey:@"repay_now"]];
                                                  
                                              }
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
                                      showLoading:YES
     ];
}


//** 取现申请操作
- (IBAction)action_CashApply:(id)sender {
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"cash":_lb_CashTotal.text}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/getRepayAll")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                            
                                               [CommonHUD showHudWithMessage:@"申请成功,请等待后台处理" delay:1.0f completion:^{
                                                   
                                                   [self backToView];
                                               }];
                                          }
                                          failure:nil
                                   networkFailure:nil
                                      showLoading:YES
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
