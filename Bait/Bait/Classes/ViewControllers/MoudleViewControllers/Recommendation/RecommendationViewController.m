//
//  MoudleFirstViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RecommendationViewController.h"

@interface RecommendationViewController ()

@end

@implementation RecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTitle:@"热门推荐"];
    
    [self customerRightNavigationBarItemWithTitle:@"活动" andImageRes:nil];
    
}


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
