//
//  MoneyMarketProducSectionDetailSection.m
//  Bait
//
//  Created by 刘轩 on 15/6/24.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketProducSectionDetailSection.h"

@implementation MoneyMarketProducSectionDetailSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setCellData:(NSDictionary *)cellData{
    if (_cellData != cellData) {
        
        [_lb_SectionTitle setText:[cellData objectForKey:@""]];
        
    }
}



@end
