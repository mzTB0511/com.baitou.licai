//
//  BaseViewController.m
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Back Action

- (void) backToPrivousViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Life Cycle

- (NSString *) action_getSelfTitle {
    
    NSString *title = nil;
    
    if (self.title.length) {
        title = self.title;
    } else if (self.navigationItem.title.length) {
        title = self.navigationItem.title;
    } else {
        title = NSStringFromClass([self class]);
    }
    
    return title;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  自定义返回按钮
     */

    // 修改 返回键 颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    // 重置返回键内容
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
 
}


-(void)setEmptyRemindImageWithRes:(NSString *)res{

    UIImageView *imgView = (UIImageView *)[self.view viewWithTag:10000];
    if(!imgView.superview){
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:res]];
        [imageView setFrame:CGRectMake(0, 0, 224, 102)];
    
        [imageView setTag:10000];
        [imageView setCenter:CGPointMake(Screen_width/2, Screen_height
/2 - 50)];//CGPointMake(self.view.center.x, self.view.center.y - 64)
        [self.view addSubview:imageView];
    }else{
        [imgView setCenter:CGPointMake(Screen_width/2, Screen_height/2 - 50)];
        [imgView setImage:[UIImage imageNamed:res]];
        [self.view bringSubviewToFront:imgView];
    }
    
    
}


-(void)removeEmptyRemindImage{
 
    UIImageView *imgView = (UIImageView *)[self.view viewWithTag:10000];
    
    if (imgView) {
        
        [imgView removeFromSuperview];
        
    }
    
}




@end
