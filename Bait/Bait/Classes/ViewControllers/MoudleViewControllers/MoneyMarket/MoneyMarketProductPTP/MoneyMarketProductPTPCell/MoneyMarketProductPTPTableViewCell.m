//
//  MoneyMarketProductPTPTableViewCell.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProductPTPTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MoneyMarketProductPTPTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)cellData{
    
    if (_cellData != cellData) {
        
        NSString *partnerStr =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"partner_ico"]];
        
        [_img_Partner sd_setImageWithURL:[NSURL URLWithString:partnerStr] placeholderImage:nil];
        
        NSString *daiIco =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"dai_url"]];
        
        [_img_DaiIco sd_setImageWithURL:[NSURL URLWithString:daiIco] placeholderImage:nil];
        
        NSString *baoIco =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"bao_url"]];
        
        [_img_BaoIco sd_setImageWithURL:[NSURL URLWithString:baoIco] placeholderImage:nil];
 
        
        [_lb_ProductName setText:[cellData objectForKey:@"product_name"]];
        [_lb_Profit setText:[cellData objectForKey:@"profit"]];
        [_lb_Deadline setText:[cellData objectForKey:@"deadline"]];
        [_lb_Limit_Cash setText:[cellData objectForKey:@"limit_cash"]];
        [_lb_ProfitTitle setText:[cellData objectForKey:@"profit_title"]];
        [_lb_DeadlineTitle setText:[cellData objectForKey:@"deadline_title"]];
        [_lb_Limit_CashTitle setText:[cellData objectForKey:@"limit_cash_title"]];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
