//
//  MyPropertyInvestmentTableViewCell.m
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyPropertyInvestmentTableViewCell.h"
#import <UIImageView+WebCache.h>


@implementation MyPropertyInvestmentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)setCellData:(NSDictionary *)cellData{
    
    if (_cellData != cellData) {
        
        NSString *urlStr =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"partner_ico"]];
        
        [_img_VenderIco sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
        
        [_lb_ProductName setText:[cellData objectForKey:@"product_name"]];
        [_lb_Limit setText:[cellData objectForKey:@"deadline"]];
        [_lb_Amount setText:[cellData objectForKey:@"purchase_amount"]];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
