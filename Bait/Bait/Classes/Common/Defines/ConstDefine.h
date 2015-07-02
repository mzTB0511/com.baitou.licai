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
#define Color_System_Tint_Color                 mRGBColor(251, 113, 114)

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
#define sbStoryBoard_Moudle_UserCenter       @"UserCenter"



//用户登陆注册
#define sbStoryBoard_Moudle_LoginRegister       @"UserLoginRegister"



//首页接收到新消息推送 显示小红点
#define Notification_Recieve_New_Message        @"Notification_Recieve_New_Message"

//登录成功
#define Notification_User_Login_Success         @"Notification_User_Login_Success"

//糖妈妈记录饮食完成
#define Notification_Suger_Mom_Add_Food         @"Notification_Suger_Mom_Add_Food"

//强制刷新首页列表
#define Notification_Home_Page_Refresh          @"Notification_Home_Page_Refresh"

//进入医生问答页面
#define Notification_Push_DoctorQA              @"Notification_Push_DoctorQA"

//进入医生指导意见页面
#define Notification_Push_DoctorAdvice          @"Notification_Push_DoctorAdvice"

//进入医生回访通知
#define Notification_Push_DoctorVisit           @"Notification_PushDoctorVisit"

//下单成功以后 刷新购物车
#define Notification_Create_Order_Success       @"Notification_Create_Order_Success"


#define User_Status_Before_Pregnancy            1001
#define User_Status_During_Pregnancy            1002
#define User_Status_After_Pregnancy             1003
#define User_Status_Just_Look                   1004


typedef enum : NSUInteger {
    MoudleThirdSugerMomMealType_1 = 1,      //早餐前
    MoudleThirdSugerMomMealType_2 = 2,      //早餐后
    MoudleThirdSugerMomMealType_3 = 3,      //午餐前
    MoudleThirdSugerMomMealType_4 = 4,      //午餐后
    MoudleThirdSugerMomMealType_5 = 5,      //晚餐前
    MoudleThirdSugerMomMealType_6 = 6,      //晚餐后
    MoudleThirdSugerMomMealType_7 = 7       //凌晨
} MoudleThirdSugerMomMealType;


typedef enum : NSUInteger {
    Notification_Message_Type_BloodPressure = 1,        //血压
    Notification_Message_Type_Weight        = 2,        //体重
    Notification_Message_Type_Sport         = 3,        //运动量
    Notification_Message_Type_BloodSugar    = 5,        //血糖
    Notification_Message_Type_DoctorReply   = 100,      //医生回复
    Notification_Message_Type_DoctorAdvice  = 200,      //医生指导意见
    Notification_Message_Type_DoctorVisit   = 300       //回访通知
} Notification_Message_Type;






