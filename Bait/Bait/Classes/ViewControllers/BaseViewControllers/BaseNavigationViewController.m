//
//  BaseNavigationViewController.m
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

-(void)awakeFromNib{
    
    [self.navigationBar setBarTintColor:Color_System_Tint_Color];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
