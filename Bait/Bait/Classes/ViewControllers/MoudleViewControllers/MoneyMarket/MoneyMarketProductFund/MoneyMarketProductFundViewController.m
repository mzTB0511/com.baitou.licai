//
//  MoneyMarketProductFundViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProductFundViewController.h"
#import "MJRefresh.h"
#import "NetworkHandle.h"

#import "MoneyMarketProductFundTableViewCell.h"


@interface MoneyMarketProductFundViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
}


@property (weak, nonatomic) IBOutlet UITableView *tbv_MoneyMarketFund;

@property (strong, nonatomic) NSMutableArray *productFundList;




@end

@implementation MoneyMarketProductFundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    _productFundList  = [NSMutableArray array];
    
    
    mRegisterNib_TableView(_tbv_MoneyMarketFund, NSStringFromClass([MoneyMarketProductFundTableViewCell class]));
    
    
    [self setupRefresh];
    
}



#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_MoneyMarketFund addHeaderWithCallback:^{
        
        pageIndex = 1;
        
        [weakSelf loadFundDataWithPage:pageIndex];

        
    }];
    
    [self.tbv_MoneyMarketFund addFooterWithCallback:^{
        
        //加载代码
        pageIndex ++;
        
        [weakSelf loadFundDataWithPage:pageIndex];
    }];
    
    //** 开始刷新
    [self.tbv_MoneyMarketFund headerBeginRefreshing];
}





-(void)loadFundDataWithPage:(NSInteger)page{
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"page_no":[NSString stringWithFormat:@"%li",(long)page],@"product_type_id":@"2"}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"product/refreshProduct")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSArray *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      if (page == 1) {
                                                          [_productFundList removeAllObjects];
                                                          
                                                      }
                                                      [_productFundList addObjectsFromArray:data];
                                                      
                                                  }
                                                  
                                                  [_tbv_MoneyMarketFund reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketFund);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketFund);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketFund);
                                          }
                                      showLoading:YES
     ];
    
}




#pragma mark -- UITabelViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 89;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _productFundList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoneyMarketProductFundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProductFundTableViewCell" forIndexPath:indexPath];
    
    [cell setCellData:[_productFundList objectAtIndex:indexPath.row]];
    
    
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
