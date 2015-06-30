//
//  ViewController.h
//  
//
//  Created by  on 14-6-26.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "UIAlertView+Blocks.h"
#import <AFNetworking.h>
#import "CommonFunc.h"
#import "FormatData.h"
//#import "DataModule.h"
#import "MBProgressHUD.h"
#import "UserInfo.h"
#import "BaseViewController.h"

@interface ViewController : BaseViewController


@property (strong, nonatomic) MBProgressHUD *HUD;


// 设置Navigation bar title
-(void) setViewTitle:(NSString *)title;

// 日期加减
-(NSDate *)getNewDataBy:(int)year WithCurrentData:(NSDate *)data;

/*-- ios7 动态计算UITextView 内容的高度*/
-(CGFloat)getControlHWithTextView:(UITextView *)textView attributes:(NSDictionary *)attributes;



//// 显示加载信息动画
//-(void) showLoadingView;
//
//// 隐藏 加载动画
//-(void) hideLoadingView;
//
//// 提醒消息
//-(void)showHintMessage:(NSString*)mesage;
//
//
//// 登陆提示消息
//-(void)showLoginMessage:(NSString*)mesage;
//
//
//// 登陆提示消息
//-(void)hideViewMessage;


// 显示加载信息动画
-(void) showLoadingView;
// 隐藏 加载动画
-(void) hideLoadingView;

-(void)showHintMessage:(NSString*)mesage;

-(void)showMessage:(NSString *)string WithAnimation:(BOOL)flag complet:(void (^)(MBProgressHUD *hud)) complet;

//** 搜索默认显示结果
-(void)setEmptyHintMessage:(NSString *)message;

-(void)removeEmptyHint;





@end
