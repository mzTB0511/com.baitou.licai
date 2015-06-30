//
//  IssueQuestionListCell.h
//  TestTableView
//
//  Created by 刘轩 on 15/6/29.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueQuestionListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb_Question;

@property (weak, nonatomic) IBOutlet UILabel *lb_Answer;

@property (weak, nonatomic) IBOutlet UIButton *btn_Arraw;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ly_center;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ly_bottom;


@end
