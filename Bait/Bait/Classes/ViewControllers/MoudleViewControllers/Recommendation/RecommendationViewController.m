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


@property(nonatomic,strong) NSArray *bannerList;

@end

@implementation RecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTitle:@"热门推荐"];
    
    [self customerRightNavigationBarItemWithTitle:@"活动" andImageRes:nil];
    
    [self loadBannerData];
    
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
