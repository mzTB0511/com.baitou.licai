//
//  MoneyMarketProducDetailTopTableViewCell.h
//  Bait
//
//  Created by 刘轩 on 15/7/3.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ProductRSSBlock)(NSString *partnerID,NSInteger controlType);

@interface MoneyMarketProducDetailTopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img_PartnerIco;

@property (weak, nonatomic) IBOutlet UIImageView *img_BaoIco;
@property (weak, nonatomic) IBOutlet UIImageView *img_DaiIco;

@property (weak, nonatomic) IBOutlet UILabel *lb_DeadlineTitle;

@property (weak, nonatomic) IBOutlet UILabel *lb_DeadlineValue;


@property (weak, nonatomic) IBOutlet UILabel *lb_ProfitTitle;

@property (weak, nonatomic) IBOutlet UILabel *lb_ProfitValue;

@property (weak, nonatomic) IBOutlet UILabel *lb_LimitCashTitle;


@property (weak, nonatomic) IBOutlet UILabel *lb_LimitCashValue;


@property (weak, nonatomic) IBOutlet UIButton *btn_RSS;

@property(nonatomic, strong) NSDictionary *cellData;

@property(nonatomic, strong) ProductRSSBlock rssBlock;


@end
