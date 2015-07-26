//
//  MoneyMarketProducSectionDetailOneViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProducSectionDetailOneViewController.h"
#import "MoneyMarketProducSectionDetailOneCell.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"


@interface MoneyMarketProducSectionDetailOneViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tbv_MarketProductSectionDetail;

@property(nonatomic,strong) NSArray *productPropertyList;

@property(nonatomic,strong) MoneyMarketProducSectionDetailOneCell *customerCell;

@property(nonatomic,strong) NSDictionary *passedProduct;


@end

@implementation MoneyMarketProducSectionDetailOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setViewTitle:@"产品介绍"];
    
    _productPropertyList = [NSMutableArray array];
    
 //  mRegisterNib_TableView(_tbv_MarketProductSectionDetail,NSStringFromClass([MoneyMarketProducSectionDetailOneCell class]));
    
    _customerCell = [self.tbv_MarketProductSectionDetail dequeueReusableCellWithIdentifier:@"MoneyMarketProducSectionDetailOneCell"];
    
    if (self.viewObject) {
        _passedProduct = (NSDictionary *)self.viewObject;
        [self setViewTitle:getValueIfNilReturnStr([_passedProduct objectForKey:@"section_name"])];
    }
    
    
    [self setupRefresh];
}

#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_MarketProductSectionDetail addHeaderWithCallback:^{
 
        [weakSelf loadDetailDataWithPage];
    }];

    
    //** 开始刷新
    [self.tbv_MarketProductSectionDetail headerBeginRefreshing];
}


-(void)loadDetailDataWithPage{
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"section_id":[_passedProduct objectForKey:@"id"],
                                                    @"product_id":[_passedProduct objectForKey:@"product_id"]}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"product/getProductDetail")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSArray *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      _productPropertyList = data;
                                                      
                                                  }
                                                  
                                                  [_tbv_MarketProductSectionDetail reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbv_MarketProductSectionDetail);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_MarketProductSectionDetail);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbv_MarketProductSectionDetail);
                                          }
                                      showLoading:YES
     ];
    
}





#pragma mark -- UITabelViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *cellDict = [_productPropertyList objectAtIndex:indexPath.row];
    
    [_customerCell.lb_PropertyTitle setText:[cellDict objectForKey:@"detail_name"]];
    [_customerCell.lb_PropertyValue setText:[cellDict objectForKey:@"detail_content"]];
    
    CGSize size = [_customerCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _productPropertyList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoneyMarketProducSectionDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProducSectionDetailOneCell" forIndexPath:indexPath];
  
    NSDictionary *cellDict = [_productPropertyList objectAtIndex:indexPath.row];
    
    [cell.lb_PropertyTitle setText:[cellDict objectForKey:@"detail_name"]];
    [cell.lb_PropertyValue setText:[cellDict objectForKey:@"detail_content"]];
    
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
