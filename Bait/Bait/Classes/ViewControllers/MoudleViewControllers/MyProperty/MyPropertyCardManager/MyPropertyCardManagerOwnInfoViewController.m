//
//  MyPropertyCardManagerOwnInfoViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyCardManagerOwnInfoViewController.h"
#import "NetworkHandle.h"

#import "BabySanteDatePicker.h"

@interface MyPropertyCardManagerOwnInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_UserName;


@property (weak, nonatomic) IBOutlet UITextField *tf_Bank;


@property (weak, nonatomic) IBOutlet UITextField *tf_VisaCardNO;

@property (weak, nonatomic) IBOutlet UIView *v_Bank;



@property (strong, nonatomic) NSMutableArray *bankList;

@property (strong, nonatomic) NSMutableDictionary *updateDict;


//** View 添加点击事件
@property(strong,nonatomic) UITapGestureRecognizer *tapRecognizer;



@end

@implementation MyPropertyCardManagerOwnInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setViewTitle:@"银行卡信息"];
    
    _bankList = [NSMutableArray array];
    _updateDict = [NSMutableDictionary dictionary];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_SelectBank)];
    _tapRecognizer.numberOfTapsRequired = 1;
    _tapRecognizer.numberOfTouchesRequired = 1;
    [_v_Bank addGestureRecognizer:_tapRecognizer];
    
    
    [self setFrameData];
    
    [self customerRightNavigationBarItemWithTitle:@"提交" andImageRes:nil];
 
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/getBank")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:Return_data]) {
                                                  
                                                  NSArray *retData = [responseDictionary objectForKey:Return_data];
                                                  
                                                  [_bankList addObjectsFromArray:retData];
                                                  
                                                
                                              }
                                              
                                             
                                          }
                                          failure:nil
                                   networkFailure:nil
                                      showLoading:YES];
    




}


-(void)setFrameData{
    
    if (_cardDict) {
        [_tf_Bank setText:[_cardDict objectForKey:@"bank_name"]];
        [_tf_UserName setText:[_cardDict objectForKey:@"card_user"]];
        [_tf_VisaCardNO setText:[_cardDict objectForKey:@"card_no"]];
       
        [_updateDict setObject:_tf_VisaCardNO.text forKey:@"card_no"];
        [_updateDict setObject:_tf_UserName.text forKey:@"card_user"];
        [_updateDict setObject:[_cardDict objectForKey:@"bank_id"] forKey:@"bank_id"];
        
        
    }
    
}


//** 重写NavigationBar右键方法
-(void)navigationRightItemEvent{
    
    if (_updateDict) {
        
        [NetworkHandle loadDataFromServerWithParamDic:_updateDict
                                              signDic:nil
                                        interfaceName:InterfaceAddressName(@"my/setMembercard")
                                              success:^(NSDictionary *responseDictionary, NSString *message) {
                                                  
                                                  [self backToView];
                                                  
                                              }
                                              failure:nil
                                       networkFailure:nil
                                          showLoading:YES];
    }
    
    
    
}


- (void)action_SelectBank{
    
    __block NSMutableArray *bankList;
    bankList = [NSMutableArray array];
    [_bankList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *dict  = (NSDictionary *)obj;
        [bankList addObject:[dict objectForKey:@"bank_name"]];
        
    }];
    
    [BabySanteDatePicker showPickerWithValues:bankList
                                 defaultIndex:0
                                        block:^(NSString *string) {
                                            
                                            [_tf_Bank setText:string];
                                            
                                            NSInteger index = [bankList indexOfObject:string];
                                            
                                            NSDictionary *dict = [_bankList objectAtIndex:index];
                                            
                                            [_updateDict setObject:[dict objectForKey:@"id"] forKey:@"bank_id"];
                                     
                                            
                                        }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
