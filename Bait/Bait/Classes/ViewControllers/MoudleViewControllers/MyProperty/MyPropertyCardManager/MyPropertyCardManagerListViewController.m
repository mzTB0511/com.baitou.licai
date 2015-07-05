//
//  MyPropertyCardManagerListViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyCardManagerListViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "MyPropertyCardManagerOwnInfoViewController.h"

@interface MyPropertyCardManagerListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbv_CardManageList;

@property (strong, nonatomic) NSArray *cardList;





@end

@implementation MyPropertyCardManagerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setViewTitle:@"银行卡管理"];
    
    [self setupRefresh];
    
}


#pragma mark - 集成下拉上提

- (void)setupRefresh
{
    
    WEAKSELF
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tbv_CardManageList addHeaderWithCallback:^{

        
        [NetworkHandle loadDataFromServerWithParamDic:nil
                                              signDic:nil
                                        interfaceName:InterfaceAddressName(@"my/getMembercard")
                                              success:^(NSDictionary *responseDictionary, NSString *message) {
                                                  
                                                  if ([responseDictionary objectForKey:Return_data]) {
                                                      
                                                      NSDictionary *retData = [responseDictionary objectForKey:Return_data];
                                                      
                                                      if ([[retData objectForKey:@"member"] isKindOfClass:[NSArray class]]) {
                                                          _cardList = [retData objectForKey:@"member"];
                                                          
                                                          [weakSelf.tbv_CardManageList reloadData];

                                                          
                                                      }
                                                
                                                      
                                                  }
                                                 
                                                  stopTableViewRefreshAnimation(_tbv_CardManageList);
                                                  
                                            }
                                              failure:^{
                                                  stopTableViewRefreshAnimation(_tbv_CardManageList);
                                              } networkFailure:^{
                                                  stopTableViewRefreshAnimation(_tbv_CardManageList);
                                              }
                                          showLoading:YES
         ];
        

        
        
    }];
    
    //** 开始刷新
    [self.tbv_CardManageList headerBeginRefreshing];
}


#pragma mark -- UITabelViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cardList.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPropertyCardListCell" forIndexPath:indexPath];
    
    NSDictionary *cellData  = [_cardList objectAtIndex:indexPath.row];
    [cell.textLabel setText:[[CommonFunc shareInstance] checkNullString:[cellData objectForKey:@"bank_name"]]];
    
    //**卡号末四位处理
    NSString *cardNo = [[CommonFunc shareInstance] checkNullString:[cellData objectForKey:@"card_no"]];
    NSString *subStr = [cardNo substringFromIndex:cardNo.length - 4];
    
    cardNo = [NSString stringWithFormat:@"末四位数 %@", subStr];
    
    [cell.detailTextLabel setText:cardNo];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    [tableView deselectRowAtIndexPath:[_tbv_CardManageList indexPathForSelectedRow] animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"push_to_OwnInfoViewController"]) {
        
        MyPropertyCardManagerOwnInfoViewController *viewController = [segue destinationViewController];
       
        NSDictionary *cellData  = [_cardList objectAtIndex:[_tbv_CardManageList indexPathForSelectedRow].row];

        viewController.cardDict = cellData;
       
    }
}


@end
