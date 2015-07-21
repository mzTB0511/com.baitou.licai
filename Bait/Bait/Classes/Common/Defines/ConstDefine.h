//
//  ConstDefine.h
//
//  Created by Yang Xudong .
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *定义一些项目中使用的常量
 */

//系统顶部颜色
#define Color_System_Tint_Color                 mRGBColor(250, 81, 59)

//view背景色
#define Color_System_View_bgColor               mRGBColor(242, 242, 242)


//Mob短信验证
#define Mob_Key                                 @""
#define Mob_App_Secret                          @""

//微信开放平台ID/Secret
#define WX_App_ID                               @"wxa6428af98aa625a3"
#define WX_App_Secret                           @"cfb98f4d9ed78d863557cde7b77ee6bc"

//友盟统计App Key
#define UMeng_App_Key                           @"5440f28cfd98c51e6b002346"
//分发渠道
#define UMeng_Channel                           @""

//高德地图key
#define AMap_Key                                @"30e52afa7811e4af40b7990ec587ca66"

//百度云推送开放平台Appid
#define BD_PUSH_App_ID                          @"SMGx2wz6TbdRqr3d8CjpsYs9"


//故事板
#define sStoryBoard_Main                        @"Main"
#define sbStoryBoard_Main                       [UIStoryboard storyboardWithName:sStoryBoard_Main bundle:nil]

//四个主要模块
#define sbStoryBoard_Moudle_More                @"More"
#define sbStoryBoard_Moudle_MoneyMarket         @"MoneyMarket"
#define sbStoryBoard_Moudle_MyProperty          @"MyProperty"
#define sbStoryBoard_Moudle_Recomendation       @"Recommendation"
#define sbStoryBoard_Moudle_UserCenter          @"UserCenter"



//用户登陆注册
#define sbStoryBoard_Moudle_LoginRegister       @"UserLoginRegister"


//**************************** 消息通知名称 键宏定义***********************************************/

//* 更多页面 登录、注册成功后通知页面刷新
#define Com_Notifation_MoreViewController         @"com.notifation.more_view"


// APP 字体文件定义
#define FontViewTitle(fontSize) [UIFont fontWithName:@"FZLTCHJW--GB1-0" size:fontSize]
#define FontOthers_CH(fontSize) [UIFont fontWithName:@"FZLTHJW--GB1-0" size:fontSize]
#define FontOthers_Number(fontSize) [UIFont fontWithName:@"DINAlternate-Bold" size:fontSize]


/**
 *  MJRefresh Tableview停止刷新
 */
#define stopTableViewRefreshAnimation(tableview)\
[tableview headerEndRefreshing];\
[tableview footerEndRefreshing];






