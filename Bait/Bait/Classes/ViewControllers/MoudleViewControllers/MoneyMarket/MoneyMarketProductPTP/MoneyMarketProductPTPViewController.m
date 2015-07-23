//
//  MoneyMarketProductPTPViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProductPTPViewController.h"
#import "MJRefresh.h"
#import "NetworkHandle.h"
#import "MoneyMarketProductPTPTableViewCell.h"
#import "MoneyMarketProducDetailViewController.h"

@interface MoneyMarketProductPTPViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
}


@property (weak, nonatomic) IBOutlet UITableView *tbv_MoneyMarketPTP;

@property(nonatomic,strong) NSMutableArray *productPTPList;



@end

@implementation MoneyMarketProductPTPViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([_tbv_MoneyMarketPTP indexPathForSelectedRow]) {
        [_tbv_MoneyMarketPTP deselectRowAtIndexPath:[_tbv_MoneyMarketPTP indexPathForSelectedRow] animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setAutomaticallyAdjustsScrollViewInsets:NO];
     _productPTPList  = [NSMutableArray array];
    
    mRegisterNib_TableView(_tbv_MoneyMarketPTP, NSStringFromClass([MoneyMarketProductPTPTableViewCell class]));
    
    [self setupRefresh];
}



#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_MoneyMarketPTP addHeaderWithCallback:^{
        
        pageIndex = 1;
        
        [weakSelf loadRebateDataWithPage:pageIndex];
    }];
    
    
    [self.tbv_MoneyMarketPTP addFooterWithCallback:^{
        
        //加载代码
        pageIndex ++;
        
        [weakSelf loadRebateDataWithPage:pageIndex];
    }];
    
    
    //** 开始刷新
    [self.tbv_MoneyMarketPTP headerBeginRefreshing];
}




-(void)loadRebateDataWithPage:(NSInteger)page{
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"page_no":[NSString stringWithFormat:@"%li",(long)page],@"product_type_id":@"1"}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"product/refreshProduct")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSArray *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      if (page == 1) {
                                                          [_productPTPList removeAllObjects];
                                                          
                                                      }
                                                      [_productPTPList addObjectsFromArray:data];
                                                      
                                                  }
                                                  
                                                  [_tbv_MoneyMarketPTP reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketPTP);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketPTP);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketPTP);
                                          }
                                      showLoading:YES
     ];
    
}




#pragma mark -- UITabelViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _productPTPList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoneyMarketProductPTPTableViewCell
    
    *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProductPTPTableViewCell" forIndexPath:indexPath];
    
     [cell setCellData:[_productPTPList objectAtIndex:indexPath.row]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    pushViewControllerWith(sbStoryBoard_Moudle_MoneyMarket, MoneyMarketProducDetailViewController, [_productPTPList objectAtIndex:indexPath.row])
    
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
