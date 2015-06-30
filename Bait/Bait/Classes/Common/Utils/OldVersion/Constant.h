
//  CommonConstant.h

/*---------------------------------工程全局变量宏定义-----------------------------------*/
#define VIEW_TYPE_QA 0
#define VIEW_TYPE_RESERVATION 1


/*---------------------------------接口返回字段定义------------------------------------*/
#pragma mark--接口返回值
// 返回JSON数据的KEY
#define MESSAGE @"error"
#define CHECK_RESULT @"code"
#define RETURN_USER_DATA @"user_data"
#define CENTER_DATA @"center_data"


#pragma mark--其他宏定义
// 消息相关
#define ALERT_TITLE_ERROR @"出错提示"
#define ALERT_TITLE_HINT @"提 示"
#define ALERT_BUTTON_CONFIRM @"确定"
#define ALERT_BUTTON_CANCEL @"确定"
#define LOADINGDATAERROR @"数据加载为空，请重试"
#define NETCONNECTERROR  @"网络不给力，稍后重试" //~o(>_<)o ~
//PushTableView相关的配置信息

#define PageSize 20

#define LoadingStatus @"正在加载中..."
#define LoadingDone @""


/********************************其它*********************************/
#pragma mark--宏方法定义
// Slide 菜单选中颜色
#define SlideMenu_Color [UIColor colorWithRed:255/255.0 green:155/255.0 blue:155/255.0 alpha:1]


//UINavigationBar 背景颜色定义
//#define NavigationBar_UserCent_IMG [UIImage imageNamed:@"nav_Bar_BG"]
//#define NavigationBar_White_Color [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]


#define NavigationBar_HomePage_IMG [UIImage imageNamed:@"nav_Bar_BG"]

//#define NavigationBar_Home_Nav [UIImage imageNamed:@"img_home_nav"]


#define NavigationBar_Red_Color [UIColor colorWithRed:255/255.0 green:155/255.0 blue:155/255.0 alpha:1]




/*本地保存到NSDocumentDirectory的路径*/
#define ODB_APP_DOC_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]



// APP 字体文件定义

#define FontViewTitle(fontSize) [UIFont fontWithName:@"FZLTCHJW--GB1-0" size:fontSize]
#define FontOthers_CH(fontSize) [UIFont fontWithName:@"FZLTHJW--GB1-0" size:fontSize]
#define FontOthers_Number(fontSize) [UIFont fontWithName:@"DINAlternate-Bold" size:fontSize]



//** 宏方法定义 --从Sb中实例化ViewController
#define getViewControllFromStoryBoard(storyBoardName,controllerName) [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:controllerName]


//** 获取图片
#define getImageWithRes(Res) [UIImage imageNamed:[NSString stringWithFormat:Res]]

//** 组合字符串
#define getStringValueWith(str,addstr) [str stringByAppendingString:addstr]

//** 返回颜色值
#define getColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


//** 返回Url地址
#define getUrlWithStr(path) [NSURL URLWithString:path]


#define getUserModule_Local (UserModule *)[[CommonFunc shareInstance] getLocalData:User_Module]


//** 版本号
#define getAPPBoundVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];


/**
 *  获取食物返回默认图片
 */
#define getDefatult_FoodImage getImageWithRes(@"img_moudle_first_food_icon")




//**************************** 键值编码 键宏定义***********************************************/
//** 是否已经登陆标示
#define IF_Login    @"if_login"

//** 是否首次登陆
#define IF_UserGuid    @"ifuserGuid"

//** 用户数据
#define User_Module    @"localUser_module"

//** 首页是否显示营养提醒图标
#define IF_ShowNutritionRemind    @"show_NutritionRemind"

//** 用户UnionID
#define Wechat_UnionID    @"wechat_unionid"


//** StoryBoard 文件定义
#define SB_Nutrition    @"Nutrition"






//**************************** 消息通知名称 键宏定义***********************************************/
//** 调用微信授权信息
#define COM_NOTIFATION_WECHATBLOCK    @"com_notifation_weichat_block"

//** 刷新套餐查看量
#define COM_NOTIFATION_PKGLOOKCOUNT    @"com_notifation_pkg_lookcount"

//** 更新选择的食物列表
#define COM_NOTIFATION_UPDATEFOODLIST    @"com_notifation_sel_foodlist"

//** 更新饮食记录列表
#define COM_NOTIFATION_UPDATEFOODRECORD    @"com_notifation_sel_foodrecord"




/*本地保存到NSDocumentDirectory的路径*/
#define ODB_APP_DOC_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// 获取屏幕宽度
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

// 判断设备是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)






typedef enum {
    MeasureType_BloodPress = 1,
    MeasureType_Weight = 2,
    MeasureType_Steps = 3,
    MeasureType_BloodGlcose = 5
}MeasureType;






