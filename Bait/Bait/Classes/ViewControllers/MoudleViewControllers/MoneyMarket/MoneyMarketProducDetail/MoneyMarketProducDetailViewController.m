//
//  MoneyMarketProducDetailViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProducDetailViewController.h"
#import "MoneyMarketProducDetailTopTableViewCell.h"
#import "NetworkHandle.h"
#import "MoneyMarketProducSectionDetailOneViewController.h"


#import "UMSocial.h"
#import "UMSocialSnsPlatformManager.h"
#import "UIActionSheet+Blocks.h"
#import <BlocksKit/UIView+BlocksKit.h>
#import "UMSocialSnsService.h"
#import "MoneyMarkeyProductDetailBuyView.h"

@interface MoneyMarketProducDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tbv_MoneyMarketPTPDetail;

@property(nonatomic,strong) NSMutableArray *productDetailList;

@end

@implementation MoneyMarketProducDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self setViewTitle:@"产品详细"];
    
    [self customerRightNavigationBarItemWithTitle:@"分享" andImageRes:nil];
    
    _productDetailList = [NSMutableArray array];
    
    if (self.viewObject) {
        NSDictionary *productItem = (NSDictionary *)self.viewObject;
        
        [self loadProductDetailWithID:[productItem objectForKey:@"id"]];
    }
    
    //** 加载底部购买按钮
    MoneyMarkeyProductDetailBuyView *buyView  = getViewByNib(MoneyMarkeyProductDetailBuyView, self);

    [buyView setFrame:CGRectMake(0, getScreenHeight - 44, getScreenWidth, getScreenHeight)];
    [self.view addSubview:buyView];
    
    [buyView bk_whenTapped:^{
       
       [CommonHUD showHudWithMessage:@"码农正在拼命赶进度..." delay:1.5f completion:^{
           
       }];
    }];
    
    
}

/**
 *  重载NavigationBar右键点击事件
 */
-(void)navigationRightItemEvent{

    WEAKSELF
    NSArray *arr_SnsList = @[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ];
    
    [UMSocialSnsService presentSnsIconSheetView:weakSelf appKey:UMeng_App_Key shareText:@"我们大家都在用百投,小伙伴快来加入吧!" shareImage:default_Image_UserIco shareToSnsNames:arr_SnsList delegate:self];
    
    

    
}

#pragma mark --UMSociaDelegate
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}




-(void)loadProductDetailWithID:(NSString *)productID{
    
     WEAKSELF
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"product_id":productID}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"product/getProductInfo")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  NSDictionary *data = [responseDictionary objectForKey:Return_data];
                                                  
                                                  [weakSelf setViewTitle:getValueIfNilReturnStr([[[data objectForKey:@"product"] objectAtIndex:0] objectForKey:@"product_name"])];
                                                  
                                                  [weakSelf makeTableViewDataSourceWithData:data];
                                              }
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                             
                                          }
                                      showLoading:YES
     ];
    
}



-(void)makeTableViewDataSourceWithData:(NSDictionary *)data{
 
    if (data) {
       
        NSDictionary *productDict = [[data objectForKey:@"product"] objectAtIndex:0];
        
        //** 产品基本信息
        NSMutableDictionary *muProductInfo = [NSMutableDictionary dictionaryWithDictionary:[[data objectForKey:@"product"] objectAtIndex:0]];
        
        [_productDetailList addObject:@[muProductInfo]];
        
        
        NSMutableArray *muProperty = [NSMutableArray array];
        for (int i= 1; i<=11 ;i++) {
            
            NSString *itemKey = [NSString stringWithFormat:@"sub_title%i",i];
            NSString *itemValue = [NSString stringWithFormat:@"sub_value%i",i];
            
            if ([productDict objectForKey:itemKey]) {
                NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
                
                if (![[productDict objectForKey:itemKey] isEqual:[NSNull null]]) {
                    [itemDict setObject:[productDict objectForKey:itemKey] forKey:@"sub_title"];
                    [itemDict setObject:[productDict objectForKey:itemValue] forKey:@"sub_value"];
                    
                    [muProperty addObject:itemDict];
                }
                
            }
        }
        
        [_productDetailList addObject:muProperty];
        
        
        //**添加 SectionData
        if ([[data objectForKey:@"product_section"] count] > 0) {
         
            [_productDetailList addObject:[data objectForKey:@"product_section"]];

        }
        
      
        [_tbv_MoneyMarketPTPDetail reloadData];
        
    }
    
    
}


/**
 *  订阅 /退订 产品功能
 *
 *  @param   partner   产品提供伤
 *  @param   type      操作类型 0:退订 ，1:订阅
 */
-(void)producdtRss:(NSString *)partner controlType:(NSInteger)type{
     
    [NetworkHandle loadDataFromServerWithParamDic:@{@"partner_id":partner,
                                                    @"is_like":[NSString stringWithFormat:@"%li",(long)type]}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"product/setProductRss")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              switch (type) {
                                                  case 0:{ //退订
                                                      [[[_productDetailList objectAtIndex:0] objectAtIndex:0] setObject:@"0" forKey:@"is_rss"];
                                                      [_tbv_MoneyMarketPTPDetail reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                  }
                                                      
                                                      break;
                                                  case 1:{//订阅
                                                      [[[_productDetailList objectAtIndex:0] objectAtIndex:0]setObject:@"1" forKey:@"is_rss"];
                                                      [_tbv_MoneyMarketPTPDetail reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                      
                                                  }
                                                      
                                                      break;
                                                      
                                                 
                                              }
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];

}



#pragma mark -- UITabelViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }else if (indexPath.section ==1){
        return 30;
    }else{
        return 44;
    }
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else if (section == 2){
        return 45;
    }
    
    return 10;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return _productDetailList.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_productDetailList objectAtIndex:section] count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            MoneyMarketProducDetailTopTableViewCell
            
            *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProducDetailTopTableViewCell" forIndexPath:indexPath];
            NSDictionary *dict = [[_productDetailList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            [cell setCellData:dict];
            WEAKSELF
            cell.rssBlock = ^(NSString *partnerID,NSInteger controlType){
              
                [weakSelf producdtRss:partnerID controlType:controlType];
            };
            
            return cell;
        }
            break;
            
        case 1:{
            
            UITableViewCell
            
            *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProducDetailPropertyTableViewCell" forIndexPath:indexPath];
            NSDictionary *dict = [[_productDetailList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            [cell.textLabel setText:[dict objectForKey:@"sub_title"]];
            [cell.detailTextLabel setText:[dict objectForKey:@"sub_value"]];
            
            return cell;
        }
            break;
        case 2:{
            
            UITableViewCell
            
            *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyMarketProducDetailSectionTableViewCell" forIndexPath:indexPath];
            NSDictionary *dict = [[_productDetailList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            [cell.textLabel setText:[dict objectForKey:@"section_name"]];
            [cell.detailTextLabel setText:@""];
            return cell;
        }
            break;
    }
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section != 2) return;
    
    NSDictionary *sectionData = [[_productDetailList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    pushViewControllerWith(sbStoryBoard_Moudle_MoneyMarket, MoneyMarketProducSectionDetailOneViewController, sectionData);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
