//
//  MoneyMarketFavouriteViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketFavouriteViewController.h"
#import "MoneyMarketProductFundTableViewCell.h"
#import "MoneyMarketProductPTPTableViewCell.h"
#import "MJRefresh.h"
#import "NetworkHandle.h"


@interface MoneyMarketFavouriteViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tbv_MoneyMarketFavourite;

@property(strong,nonatomic) NSMutableArray *productFavouriteList;


@end

@implementation MoneyMarketFavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    _productFavouriteList  = [NSMutableArray array];
    
    
    mRegisterNib_TableView(_tbv_MoneyMarketFavourite, NSStringFromClass([MoneyMarketProductPTPTableViewCell class]));
    
    mRegisterNib_TableView(_tbv_MoneyMarketFavourite, NSStringFromClass([MoneyMarketProductFundTableViewCell class]));

     [self setupRefresh];

}




#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_MoneyMarketFavourite addHeaderWithCallback:^{
        
        pageIndex = 1;
        
        [weakSelf loadFavouriteDataWithPage:pageIndex];
        
        
    }];
    
    [self.tbv_MoneyMarketFavourite addFooterWithCallback:^{
        
        //加载代码
        pageIndex ++;
        
        [weakSelf loadFavouriteDataWithPage:pageIndex];
    }];
    
    //** 开始刷新
    [self.tbv_MoneyMarketFavourite headerBeginRefreshing];
}



-(void)loadFavouriteDataWithPage:(NSInteger)page{
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"page_no":[NSString stringWithFormat:@"%li",(long)page],@"product_type_id":@"3"}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"product/refreshProduct")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSArray *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      if (page == 1) {
                                                          [_productFavouriteList removeAllObjects];
                                                          
                                                      }
                                                      [_productFavouriteList addObjectsFromArray:data];
                                                      
                                                  }
                                                  
                                                  [_tbv_MoneyMarketFavourite reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketFavourite);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketFavourite);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_MoneyMarketFavourite);
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
    
    return _productFavouriteList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoneyMarketProductFundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProductFundTableViewCell" forIndexPath:indexPath];

    
    [cell setCellData:[_productFavouriteList objectAtIndex:indexPath.row]];
    
    
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
