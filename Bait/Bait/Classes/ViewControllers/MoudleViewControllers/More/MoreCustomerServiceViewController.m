//
//  MoreCustomerServiceViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoreCustomerServiceViewController.h"

@interface MoreCustomerServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbv_CustomerService;



@end

@implementation MoreCustomerServiceViewController

#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return (section == 0) ? 3 : 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerServiceCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"微信公众号:baitou_23434"];
            [cell.imageView setImage:getImageWithRes(@"img_More_Services_Wachat")];
        }else if (indexPath.row ==1){
            [cell.textLabel setText:@"官方客服:QQ2323434"];
            [cell.imageView setImage:getImageWithRes(@"img_More_Services_QQ")];
        }else if (indexPath.row ==2){
            [cell.textLabel setText:@"新浪微博:baitou_xinlang1232"];
            [cell.imageView setImage:getImageWithRes(@"img_More_Services_Weibo")];
        }
        
    }else{
        [cell.textLabel setText:@"客服热线: 4006-977-977"];
        [cell.imageView setImage:getImageWithRes(@"img_More_Services_Tellphone")];
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        [UIAlertView showAlertViewWithTitle:nil message:@"400-888-8888" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://40088888888"]];
        } onCancel:^{
            
        }];
    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self setViewTitle:@"客户服务"];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
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
