//
//  MyPropertyRebateRecordsTableViewCell.m
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyRebateRecordsTableViewCell.h"

@implementation MyPropertyRebateRecordsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)cellData{
    
    if (_cellData != cellData) {
        
        [_lb_ProductName setText:[cellData objectForKey:@"product_name"]];
        [_lb_BuyCash setText:[cellData objectForKey:@"purchase_amount"]];
        [_lb_Rebate setText:[cellData objectForKey:@"repay_cash"]];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
