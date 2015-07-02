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
    
}

//** 重写NavigationBar右键方法
-(void)navigationRightItemEvent{
    
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
