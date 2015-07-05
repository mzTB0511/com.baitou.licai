//
//  MyPropertyCardManagerOwnInfoViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyCardManagerOwnInfoViewController.h"
#import "NetworkHandle.h"

@interface MyPropertyCardManagerOwnInfoViewController ()

@end

@implementation MyPropertyCardManagerOwnInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setViewTitle:@"银行卡信息"];
    
    [self customerRightNavigationBarItemWithTitle:@"提交" andImageRes:nil];
  /*
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/getMembercard")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  
                                                  NSDictionary *retData = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if ([[retData objectForKey:@"member"] isKindOfClass:[NSArray class]]) {
                                                      _cardList = [retData objectForKey:@"member"];
                                                      
                                                      [weakSelf.tbv_CardManageList reloadData];
                                                      
                                                      
                                                  }
                                                  
                                                  
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_CardManageList);
                                              
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_CardManageList);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_CardManageList);
                                          }
                                      showLoading:YES
     ];
    
    
    
    
}];

*/


}

//** 重写NavigationBar右键方法
-(void)navigationRightItemEvent{
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
