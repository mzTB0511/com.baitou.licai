//
//  IssueModule.h
//  TestTableView
//
//  Created by 刘轩 on 15/6/29.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssueModule : NSObject

//** 问题类型
@property(nonatomic,strong) NSString *issueType;

//** 问题描述
@property(nonatomic,strong) NSString *question;

//** 问题答案
@property(nonatomic,strong) NSString *answer;


@end
