//
//  MyPropertyCardManagerListViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyCardManagerListViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"

@interface MyPropertyCardManagerListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbv_CardManageList;

@property (strong, nonatomic) NSArray *cardList;




@end

@implementation MyPropertyCardManagerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setViewTitle:@"银行卡管理"];
    
    [self setupRefresh];
    
}


#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_CardManageList addHeaderWithCallback:^{

        [weakSelf.tbv_CardManageList reloadData];
        
        
    }];
    
    //** 开始刷新
    [self.tbv_CardManageList headerBeginRefreshing];
}


#pragma mark -- UITabelViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cardList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPropertyCardListCell" forIndexPath:indexPath];
    
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
