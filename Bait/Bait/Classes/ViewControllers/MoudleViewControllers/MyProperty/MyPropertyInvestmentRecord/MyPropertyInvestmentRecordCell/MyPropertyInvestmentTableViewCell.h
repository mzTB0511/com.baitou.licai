//
//  MyPropertyInvestmentTableViewCell.h
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPropertyInvestmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb_ProductName;

@property (weak, nonatomic) IBOutlet UIImageView *img_VenderIco;


@property (weak, nonatomic) IBOutlet UILabel *lb_Limit;


@property (weak, nonatomic) IBOutlet UILabel *lb_Amount;


@property(strong, nonatomic) NSDictionary *cellData;


@end
