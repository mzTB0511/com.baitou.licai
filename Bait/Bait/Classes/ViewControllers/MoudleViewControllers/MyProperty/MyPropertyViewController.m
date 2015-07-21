//
//  MoudleThirdViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyViewController.h"
#import "MyPropertyRebateRecordsViewController.h"
#import "MyPropertyGetCashViewController.h"
#import "MyPropertyInvestmentRecordViewController.h"
#import "MyPropertyCardManagerListViewController.h"

#import "NetworkHandle.h"


@interface MyPropertyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lb_RebateNow;

@property (weak, nonatomic) IBOutlet UILabel *lb_RebateAll;


@property (weak, nonatomic) IBOutlet UIView *v_RebateNowBgView;

@property (weak, nonatomic) IBOutlet UILabel *lb_RebateNowNull;






@end

@implementation MyPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewTitle:@"我的百投"];
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/getRepayAll")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                           
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSDictionary *rebateDict = [[responseDictionary objectForKey:Return_data] objectAtIndex:0];
                                                  
                                                  
                                                  NSString *rebateNow = getValueIfNilReturnDefaultStr([rebateDict objectForKey:@"repay_now"],@"");
                                                  
                                                   NSString *rebateAll = getValueIfNilReturnDefaultStr([rebateDict objectForKey:@"repay_all"],@"0.00");
                                               
                                                  if (isEmpty(rebateNow)) {
                                                      
                                                      [_lb_RebateNowNull setHidden:NO];
                                                      [_v_RebateNowBgView setHidden:YES];
                                                      
                                                  }else{
                                                      [_lb_RebateNowNull setHidden:YES];
                                                      [_v_RebateNowBgView setHidden:NO];
                                                      [weakSelf.lb_RebateNow setText:rebateNow];
                                                  }
                                                  
                                                  
                                                  [weakSelf.lb_RebateAll setText:rebateAll];
                                              }
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
                                      showLoading:YES
     ];

    
}


//**我的返利
- (IBAction)action_MyRebase:(id)sender {
    pushViewControllerWith(sbStoryBoard_Moudle_MyProperty, MyPropertyRebateRecordsViewController, nil);
}


//**返利取现
- (IBAction)action_PropertyCash:(id)sender {
    pushViewControllerWith(sbStoryBoard_Moudle_MyProperty, MyPropertyGetCashViewController, nil);
}


//**投资记录
- (IBAction)action_PropertyRecord:(id)sender {
    pushViewControllerWith(sbStoryBoard_Moudle_MyProperty, MyPropertyInvestmentRecordViewController, nil);
}


//**银行卡管理
- (IBAction)action_CardManager:(id)sender {
    pushViewControllerWith(sbStoryBoard_Moudle_MyProperty, MyPropertyCardManagerListViewController, nil);
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
