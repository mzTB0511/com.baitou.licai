//
//  RecommendActivityTableViewCell.m
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RecommendActivityTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation RecommendActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.view_BGView.layer.cornerRadius = 5;
    self.view_BGView.layer.masksToBounds = YES;
}



-(void)setCellData:(NSDictionary *)cellData{
    
    if (_cellData != cellData) {
        
        NSString *activeImg =[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"img_url"]];
        
        [_img_ActivityImg sd_setImageWithURL:[NSURL URLWithString:activeImg] placeholderImage:nil];
        
        NSInteger status =[[CommonIO ifNilValueReturnStr:[cellData objectForKey:@"status"]] intValue];
        
        NSString *imgRes;
        imgRes = status == 0 ? @"" : @"";
        
        [_img_Status setImage:[UIImage imageNamed:imgRes]];
        
        [_lb_ActivityName setText:[cellData objectForKey:@"title"]];
        [_lb_Time setText:[cellData objectForKey:@"insert_time"]];
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
