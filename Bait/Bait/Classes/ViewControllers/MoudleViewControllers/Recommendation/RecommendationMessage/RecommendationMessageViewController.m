//
//  RecommendationMessageViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RecommendationMessageViewController.h"
#import "RecommendtionMessageTableViewCell.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"

@interface RecommendationMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageIndex;
}


@property (weak, nonatomic) IBOutlet UITableView *tbv_RecommendationMessage;

@property(nonatomic,strong) NSMutableArray *MessageList;

@property(nonatomic,strong) RecommendtionMessageTableViewCell *customerCell;

@end

@implementation RecommendationMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _MessageList = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    
    _customerCell = [self.tbv_RecommendationMessage dequeueReusableCellWithIdentifier:@"RecommendtionMessageTableViewCell"];
    [self setupRefresh];
}



#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_RecommendationMessage addHeaderWithCallback:^{
        
        pageIndex = 1;
        
        [weakSelf loadMessageDataWithPage:pageIndex];
    }];
    
    
    [self.tbv_RecommendationMessage addFooterWithCallback:^{
        
        //加载代码
        pageIndex ++;
        
        [weakSelf loadMessageDataWithPage:pageIndex];
    }];
    
    //** 开始刷新
    [self.tbv_RecommendationMessage headerBeginRefreshing];
}


-(void)loadMessageDataWithPage:(NSInteger)page{
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"page_no":[NSString stringWithFormat:@"%li",(long)page]}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"recomend/message")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSArray *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      if (page == 1) {
                                                          [_MessageList removeAllObjects];
                                                          
                                                      }
                                                      [_MessageList addObjectsFromArray:data];
                                                      
                                                  }
                                                  
                                                  [_tbv_RecommendationMessage reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_RecommendationMessage);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_RecommendationMessage);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_RecommendationMessage);
                                          }
                                      showLoading:YES
     ];
    
}



#pragma mark -- UITabelViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *cellDict = [_MessageList objectAtIndex:indexPath.row];

    [_customerCell.lb_time setText:[cellDict objectForKey:@"insert_time"]];
    [_customerCell.lb_Message setText:[cellDict objectForKey:@"message_content"]];

    CGSize size = [_customerCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _MessageList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendtionMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendtionMessageTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *cellDict = [_MessageList objectAtIndex:indexPath.row];
    
    [cell.lb_time setText:[cellDict objectForKey:@"insert_time"]];
    [cell.lb_Message setText:[cellDict objectForKey:@"message_content"]];
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
