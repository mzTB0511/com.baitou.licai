//
//  RecommendationActivityViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RecommendationActivityViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "RecommendActivityTableViewCell.h"
#import "TOWebViewController.h"

@interface RecommendationActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tbv_RecommendationActivity;

@property(nonatomic,strong)NSMutableArray *activityList;



@end

@implementation RecommendationActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _activityList = [NSMutableArray array];
    
    [self setupRefresh];
}



#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_RecommendationActivity addHeaderWithCallback:^{
        
        pageIndex = 1;
        
        [weakSelf loadRebateDataWithPage:pageIndex];
    }];
    
    
    [self.tbv_RecommendationActivity addFooterWithCallback:^{
        
        //加载代码
        pageIndex ++;
        
        [weakSelf loadRebateDataWithPage:pageIndex];
    }];
    
    
    //** 开始刷新
    [self.tbv_RecommendationActivity headerBeginRefreshing];
}



-(void)loadRebateDataWithPage:(NSInteger)page{
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"page_no":[NSString stringWithFormat:@"%li",(long)page]}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"recomend/activity")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSArray *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      if (page == 1) {
                                                          [_activityList removeAllObjects];
                                                          
                                                      }
                                                      [_activityList addObjectsFromArray:data];
                                                      
                                                  }
                                                  
                                                  [_tbv_RecommendationActivity reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_RecommendationActivity);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_RecommendationActivity);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_RecommendationActivity);
                                          }
                                      showLoading:YES
     ];
    
}



#pragma mark -- UITabelViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _activityList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendActivityTableViewCell" forIndexPath:indexPath];
    
    [cell setCellData:[_activityList objectAtIndex:indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = [_activityList objectAtIndex:indexPath.row];
    NSString *urlStr = [CommonIO ifNilValueReturnStr:[dict objectForKey:@"img_link_url"]];
    
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [webViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:webViewController animated:YES];
    
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
