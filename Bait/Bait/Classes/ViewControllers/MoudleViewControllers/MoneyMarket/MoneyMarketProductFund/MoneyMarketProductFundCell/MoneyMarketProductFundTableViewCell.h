//
//  MoneyMarketProductFundTableViewCell.h
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyMarketProductFundTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *img_Partner;

@property (weak, nonatomic) IBOutlet UILabel *lb_ProductName;

@property (weak, nonatomic) IBOutlet UILabel *lb_Profit;

@property (weak, nonatomic) IBOutlet UILabel *lb_Limit_Cash;


@property (weak, nonatomic) IBOutlet UILabel *lb_ProfitTitle;

@property (weak, nonatomic) IBOutlet UILabel *lb_Limit_CashTitle;


@property(nonatomic ,strong) NSDictionary *cellData;

@end
