//
//  MyPropertyRebateRecordsViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyRebateRecordsViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "MyPropertyRebateRecordsTableViewCell.h"

@interface MyPropertyRebateRecordsViewController ()
{
    NSInteger pageIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tbv_RebateList;

@property (strong, nonatomic) NSMutableArray *rebateList;


@end

@implementation MyPropertyRebateRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _rebateList  = [NSMutableArray array];
    
    [self setViewTitle:@"我的返利"];
    
    [self setupRefresh];
}



#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_RebateList addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tbv_RebateList addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //    [self.view_newsView setFooterHidden:YES];
     [self headerRereshing];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //刷新代码
    pageIndex = 1;
    
    [self loadRebateDataWithPage:pageIndex];
    
}


- (void)footerRereshing
{
    //加载代码
    pageIndex ++;
    
     [self loadRebateDataWithPage:pageIndex];
}


-(void)loadRebateDataWithPage:(NSInteger)page{
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"page_no":[NSString stringWithFormat:@"%li",(long)page]}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/getRepay")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                   NSArray *data = [responseDictionary objectForKey:Return_data];
                                                 
                                                  if (data.count > 0) {
                                                      
                                                  if (page == 1) {
                                                      [_rebateList removeAllObjects];
                                                      
                                                  }
                                                      [_rebateList addObjectsFromArray:data];
                                                      
                                                  }
                                                  
                                                  [_tbv_RebateList reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_RebateList);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_RebateList);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_RebateList);
                                          }
                                      showLoading:YES
     ];
    
}


#pragma mark -- UITabelViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
        return _rebateList.count;
  
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPropertyRebateRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPropertyRebateRecordsTableViewCell.h" forIndexPath:indexPath];
    
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
