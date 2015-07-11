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


@interface MoneyMarketProducDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tbv_MoneyMarketPTPDetail;

@property(nonatomic,strong) NSMutableArray *productDetailList;

@end

@implementation MoneyMarketProducDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self setViewTitle:@"产品详细"];
    
    _productDetailList = [NSMutableArray array];
    
    if (self.viewObject) {
        NSDictionary *productItem = (NSDictionary *)self.viewObject;
        
        [self loadProductDetailWithID:[productItem objectForKey:@"id"]];
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
        [_productDetailList addObject:[data objectForKey:@"product"]];
        
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



#pragma mark -- UITabelViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
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
    }else{
        return 10;
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
