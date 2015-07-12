//
//  MoudleFirstViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RecommendationViewController.h"
#import "RecommendationServiceViewController.h"
#import "LXCycleScrollView.h"
#import "NetworkHandle.h"
#import "TOWebViewController.h"

#import <UIImageView+WebCache.h>


@interface RecommendationViewController ()<LXCycleScrollViewDelegate,LXCycleScrollViewDatasource>


@property (weak, nonatomic) IBOutlet UIView *scrollview_CycleScrollView;


@property (weak, nonatomic) IBOutlet UILabel *lb_ProductName;

@property (weak, nonatomic) IBOutlet UIImageView *img_BaoIco;

@property (weak, nonatomic) IBOutlet UIImageView *img_DaiIco;


@property (weak, nonatomic) IBOutlet UILabel *lb_Limit_Cash_Title;
@property (weak, nonatomic) IBOutlet UILabel *lb_Profit_Title;

@property (weak, nonatomic) IBOutlet UILabel *lb_Deadline_Title;


@property (weak, nonatomic) IBOutlet UILabel *lb_Limit_Cash;
@property (weak, nonatomic) IBOutlet UILabel *lb_Profit;

@property (weak, nonatomic) IBOutlet UILabel *lb_Deadline;


@property(nonatomic,strong) NSArray *bannerList;

@end

@implementation RecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTitle:@"热门推荐"];
    
    [self customerRightNavigationBarItemWithTitle:nil andImageRes:@"btn_recommend_msg"];
    
    [self loadBannerData];
    
    [self loadRecomendDataFromServer];
}


-(void)loadBannerData{
    
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"recomend/banner")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSArray *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      _bannerList = data;
                                                      
                                                      LXCycleScrollView *view = [[LXCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 150)];
                                                      
                                                      //** 初始化ScrollVeiw
                                                      view.delegate = self ;
                                                      view.datasource = self;
                                                      [_scrollview_CycleScrollView addSubview:view];
                                                      
                                                      
                                                  }
                                                  
                                                  
                                              }
                                              
                                              
                                          }
                                          failure:^{
                                             
                                          } networkFailure:^{
                                             
                                          }
                                      showLoading:YES
     ];
    
}


/**
 *  网络加载推荐产品信息
 */
-(void)loadRecomendDataFromServer{
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"recomend/hotproduct")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSDictionary *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      [weakSelf setRecomendProductDataWith:data];
                                                      
                                                  }
                                                  
                                              }
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
}



/**
 *  设置推荐位产品信息
 */
-(void)setRecomendProductDataWith:(NSDictionary *)product{
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [_lb_ProductName setText:[product objectForKey:@"product_name"]];
        [_lb_Limit_Cash_Title setText:[product objectForKey:@"limit_cash_title"]];
        
        [_lb_Profit_Title setText:[product objectForKey:@"profit_title"]];
        
        [_lb_Deadline_Title setText:[product objectForKey:@"deadline_title"]];
        
        [_lb_Limit_Cash setText:[product objectForKey:@"limit_cash"]];
        [_lb_Profit setText:[product objectForKey:@"profit"]];
        [_lb_Deadline setText:[product objectForKey:@"deadline"]];
        
        [_img_BaoIco sd_setImageWithURL:[NSURL URLWithString:[product objectForKey:@"bao_url"]] placeholderImage:nil];
        [_img_DaiIco sd_setImageWithURL:[NSURL URLWithString:[product objectForKey:@"dai_url"]] placeholderImage:nil];

    });
}




-(void)navigationRightItemEvent{
    pushViewControllerWith(sbStoryBoard_Moudle_Recomendation, RecommendationServiceViewController, nil);
    
}



#pragma mark -- CycleScrollVeiwDelegate
- (NSInteger)numberOfPages{
    return _bannerList.count;
}
- (UIView *)pageAtIndex:(NSInteger)index{

    NSDictionary *dict = [_bannerList objectAtIndex:index];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 150)];
    [image sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"img_url"]] placeholderImage:nil];
   
    return  image;
    
    
}


- (void)didClickPage:(LXCycleScrollView *)csView atIndex:(NSInteger)index{
    
     NSDictionary *dict = [_bannerList objectAtIndex:index];
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
