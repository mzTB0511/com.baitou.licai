//
//  MoneyMarketProducDetailTopTableViewCell.m
//  Bait
//
//  Created by 刘轩 on 15/7/3.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProducDetailTopTableViewCell.h"
#import <UIImageView+WebCache.h>


@implementation MoneyMarketProducDetailTopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)setCellData:(NSDictionary *)cellData{
    
    if (_cellData != cellData) {
        
        NSString *partnerStr =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"partner_ico"]];
        
        [_img_PartnerIco sd_setImageWithURL:[NSURL URLWithString:partnerStr] placeholderImage:nil];
        
        NSString *daiIco =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"dai_url"]];
        
        [_img_DaiIco sd_setImageWithURL:[NSURL URLWithString:daiIco] placeholderImage:nil];
        
        NSString *baoIco =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"bao_url"]];
        
        [_img_BaoIco sd_setImageWithURL:[NSURL URLWithString:baoIco] placeholderImage:nil];
        
        
        [_lb_DeadlineTitle setText:[cellData objectForKey:@"deadline_title"]];
        [_lb_DeadlineValue setText:[cellData objectForKey:@"deadline"]];
       
        [_lb_ProfitTitle setText:[cellData objectForKey:@"profit_title"]];
        [_lb_ProfitValue setText:[cellData objectForKey:@"profit"]];
        
        [_lb_LimitCashTitle setText:[cellData objectForKey:@"limit_cash_title"]];
        [_lb_LimitCashValue setText:[cellData objectForKey:@"limit_cash"]];
       
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
