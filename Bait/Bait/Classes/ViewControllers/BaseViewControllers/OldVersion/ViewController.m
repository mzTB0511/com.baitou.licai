//
//  ViewController.m
//  
//
//  Created by  on 14-6-26.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "ViewController.h"
#import "HLoadingView.h"

@interface ViewController ()<MBProgressHUDDelegate>

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:getColorWithRGBA(242, 242, 242, 1)];
    

    // 初始化 指示器
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.delegate = self;
    
    
//       [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置Navigation bar title
-(void) setViewTitle:(NSString *)title
{

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor blackColor],
                                NSForegroundColorAttributeName,
                                [UIFont boldSystemFontOfSize:19],
                                NSFontAttributeName,
                                nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationItem.title = title;
    
}

// 日期加减函数
-(NSDate *)getNewDataBy:(int)year WithCurrentData:(NSDate *)data
{
    NSDate *valentinesDay = [NSDate date];
    NSLog(@"Valentine's Day = %@", valentinesDay);
    NSDateComponents *weekBeforeDateComponents = [[NSDateComponents
                                                   alloc] init];
    weekBeforeDateComponents.year = year;
    NSDate *vDayShoppingDay = [[NSCalendar currentCalendar]
                               dateByAddingComponents:weekBeforeDateComponents
                               toDate:valentinesDay
                               options:0];
    
    return vDayShoppingDay;
}


/* ios7 动态计算UITextView 内容的高度*/
-(CGFloat)getControlHWithTextView:(UITextView *)textView attributes:(NSDictionary *)attributes
{
    CGFloat textViewH;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        CGRect txtFrame = textView.frame;
        textViewH = txtFrame.size.height =[[NSString stringWithFormat:@"%@\n ",textView.text] boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading                           attributes:attributes
                                                                                                           context:nil].size.height;
    }else{
        textViewH = textView.contentSize.height;
    }
    
    return textViewH;
}

//
//// 加载 状态状态栏显示
//// 显示加载信息动画
//-(void) showLoadingView
//{
//    [HLoadingView showDefaultLoadingView];
//}
//
//// 隐藏 加载动画
//-(void) hideLoadingView
//{
//    [HLoadingView hideWithAnimated:YES];
//}
//
//// 提醒消息
//-(void)showHintMessage:(NSString*)mesage
//{
//    [HLoadingView showInView:self.view image:nil info:mesage animated:YES modeled:YES autoHide:YES];
//}
//
//// 登陆提示消息
//-(void)showLoginMessage:(NSString*)mesage
//{
//    [HLoadingView showInView:self.view image:nil info:mesage animated:YES modeled:YES autoHide:NO];
//}
//
//
//// 隐藏提示消息
//-(void)hideViewMessage
//{
//    [HLoadingView hideWithAnimated:YES];
//}



// 加载 状态状态栏显示
// 显示加载信息动画
-(void) showLoadingView
{
    //[ProgressHUD show:@"加载中.."];
    if (!_HUD) {
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        
        _HUD.delegate = self;
    }
    
    _HUD.labelText = @"加载中..";
    [_HUD show:YES];
}


// 隐藏 加载动画
-(void) hideLoadingView
{
    //[ProgressHUD dismiss];
    [_HUD hide:YES];
}

// 提醒消息
-(void)showHintMessage:(NSString*)mesage
{
    //[ProgressHUD show:mesage];
    if (!_HUD) {
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        //_HUD.dimBackground = YES;
        _HUD.delegate = self;
    }
    [self.view bringSubviewToFront:_HUD];
    _HUD.labelText = mesage;
    [_HUD show:YES];
}


-(void)showMessage:(NSString *)string WithAnimation:(BOOL)flag complet:(void (^)(MBProgressHUD *hud)) complet{
    
#if NS_BLOCKS_AVAILABLE
    
    if (!_HUD) {
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        
        _HUD.delegate = self;
    }
    [self.view bringSubviewToFront:_HUD];
    _HUD.labelText = string;
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        [self myTask];
    } completionBlock:^{
        //	[_HUD removeFromSuperview];
        if (complet){
            complet(_HUD);
        }
    }];
#endif
}



- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(1);
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
}




-(void)setEmptyHintMessage:(NSString *)message{
    
    NSString *msg =@"";
    
    if (!message) {
        msg = @"空空如也";
    }else{
        msg = message;
    }
    
    UILabel *label = (UILabel *)[self.view viewWithTag:10000];
    if(!label.superview){
        UILabel *label_Hint = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 30)];
        [label_Hint setBackgroundColor:[UIColor clearColor]];
        [label_Hint setText:msg];
        [label_Hint setFont:FontOthers_CH(20)];
        [label_Hint setCenter:CGPointMake(Screen_width/2, Screen_height/2 - 50)];
        [label_Hint setTextColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
        [label_Hint setTextAlignment:NSTextAlignmentCenter];
        [label_Hint setTag:10000];
        [self.view addSubview:label_Hint];
    }else{
        [label setText:msg];
        [label setFont:FontOthers_CH(20)];
    }
    
    
}

-(void)removeEmptyHint{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:10000];
    [label removeFromSuperview];
}


@end
