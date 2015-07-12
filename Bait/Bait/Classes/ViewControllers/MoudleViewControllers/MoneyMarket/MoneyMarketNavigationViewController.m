//
//  MoneyMarketNavigationViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/30.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketNavigationViewController.h"

@interface MoneyMarketNavigationViewController ()

@end

@implementation MoneyMarketNavigationViewController

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self.navigationBar setBarTintColor:Color_System_Tint_Color];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //**修改理财超市模块根视图
    NSMutableArray *viewController = [NSMutableArray arrayWithArray:self.viewControllers];
    
    UIStoryboard *sbStoryBoard_Market = mLoadStoryboard(sbStoryBoard_Moudle_MoneyMarket);
    
    UIViewController *secView = (UIViewController *)mLoadViewController(sbStoryBoard_Market,@"MoneyMarketViewController");
    
    [viewController addObject:secView];
    
    self.viewControllers = viewController;
    
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
