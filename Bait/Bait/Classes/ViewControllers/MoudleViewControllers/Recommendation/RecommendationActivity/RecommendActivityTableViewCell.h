//
//  RecommendActivityTableViewCell.h
//  Bait
//
//  Created by 刘轩 on 15/7/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb_ActivityName;

@property (weak, nonatomic) IBOutlet UILabel *lb_Time;

@property (weak, nonatomic) IBOutlet UIImageView *img_ActivityImg;

@property (weak, nonatomic) IBOutlet UIImageView *img_Status;

@property(strong, nonatomic) NSDictionary *cellData;

@property (weak, nonatomic) IBOutlet UIView *view_BGView;


@end
