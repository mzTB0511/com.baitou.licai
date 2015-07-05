//
//  MoreFadebackViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoreFadebackViewController.h"
#import "PlaceholdeTextView.h"
#import "NetworkHandle.h"


@interface MoreFadebackViewController ()

@property (weak, nonatomic) IBOutlet PlaceholdeTextView *label_questionContent;


@end

@implementation MoreFadebackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self setViewTitle:@"意见反馈"];

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self customerRightNavigationBarItemWithTitle:@"提交" andImageRes:nil];
    
    [_label_questionContent setPlaceholder:@"请输入反馈内容,255字以内"];
}



- (BOOL)checkDataBeforeCommit{
    
    
    if ([self.label_questionContent.text length] == 0){
        [[CommonFunc shareInstance] showHintMessage:@"请输入反馈内容"];
        return NO;
    }
    
    return YES;
    
}




-(void)navigationRightItemEvent{
    
    [self.view endEditing:YES];
    
    if ([self checkDataBeforeCommit]) {
        
        [NetworkHandle loadDataFromServerWithParamDic:@{@"content":self.label_questionContent.text}
                                              signDic:nil
                                        interfaceName:InterfaceAddressName(@"user/feedback")
                                              success:^(NSDictionary *responseDictionary, NSString *message) {
                                                  [CommonHUD showHudWithMessage:@"提交成功" delay:CommonHudShowDuration completion:^{
                                                      [self.navigationController popViewControllerAnimated:YES];
                                                  }];
                                              }
                                              failure:nil
                                       networkFailure:nil];
        
    }
    
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
