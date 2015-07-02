//
//  MyPropertyInvestmentRecordViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyInvestmentRecordViewController.h"
#import "MyPropertyInvestmentTableViewCell.h"
#import "MyPropertyInvestmentHeaderView.h"

#import "NetworkHandle.h"
#import "MJRefresh.h"

@interface MyPropertyInvestmentRecordViewController ()
{
    NSInteger pageIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tbv_investmentList;

@property (strong, nonatomic) NSArray *investmentList;

@end

@implementation MyPropertyInvestmentRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTitle:@"投资记录"];
    [self setupRefresh];
    
    mRegisterHeaderFooterNib_TableView(_tbv_investmentList, NSStringFromClass([MyPropertyInvestmentHeaderView class]));
    
    mRegisterNib_TableView(_tbv_investmentList, NSStringFromClass([MyPropertyInvestmentTableViewCell class]));
    
    
    
    
}




#pragma mark - 集成下拉上提

- (void)setupRefresh
{
   
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_investmentList addHeaderWithCallback:^{
         pageIndex = 1;
        
        [weakSelf.tbv_investmentList reloadData];
        
        
    }];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tbv_investmentList addFooterWithCallback:^{
        
        //加载代码
        pageIndex ++;

        [weakSelf.tbv_investmentList reloadData];
    }];
    
    //** 开始刷新
    [self.tbv_investmentList headerBeginRefreshing];
}


#pragma mark -- UITabelViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _investmentList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPropertyInvestmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPropertyInvestmentTableViewCell" forIndexPath:indexPath];
    
    return cell;
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
