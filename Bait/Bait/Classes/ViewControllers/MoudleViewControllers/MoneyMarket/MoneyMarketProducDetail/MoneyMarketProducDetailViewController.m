//
//  MoneyMarketProducDetailViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProducDetailViewController.h"
#import "MoneyMarketProducDetailTopTableViewCell.h"
#import "NetworkHandle.h"

@interface MoneyMarketProducDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tbv_MoneyMarketPTP;

@property(nonatomic,strong) NSMutableArray *productDetailList;

@end

@implementation MoneyMarketProducDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



#pragma mark -- UITabelViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _productDetailList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoneyMarketProducDetailTopTableViewCell
    
    *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProducDetailTopTableViewCell" forIndexPath:indexPath];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
