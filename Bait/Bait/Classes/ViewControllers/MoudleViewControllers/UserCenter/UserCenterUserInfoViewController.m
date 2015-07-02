//
//  UserCenterUserInfoViewController.m
//  Bait
//
//  Created by 刘轩 on 15/7/1.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "UserCenterUserInfoViewController.h"
#import "MoudleFourthUserInfoAvatarCell.h"
#import "UserInfoHeaderFooterView.h"
#import "UIViewController+ImagePicker.h"

#import "EditPhoneNewPhoneViewController.h"
#import "EditPhoneVeriferPwdViewController.h"
#import "EditPhoneNewPwdViewController.h"
#import "UserCenterCardVerifierViewController.h"

@interface UserCenterUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbv_UserInfoTableView;

@property (nonatomic, strong) NSArray *arr_dataSource;

@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, strong) UIImage *avatarImage;

@end

@implementation UserCenterUserInfoViewController


#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arr_dataSource.count;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_arr_dataSource objectAtIndex:section] count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        return 80;
    }
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }
    
    UserInfoHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UserInfoHeaderFooterView"];
    
    switch (section) {
        case 2:
            [view.UserInfoHeaderTitle setText:@"登录密码管理"];
            break;
            
        default:
            break;
    }
    
    return view;
   // return (section == 0)? nil : (mLoadNib(@"UserInfoHeaderFooterView"));
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        if (indexPath.section == 0) {
            
            MoudleFourthUserInfoAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MoudleFourthUserInfoAvatarCell class]) forIndexPath:indexPath];
            
            [cell action_setupCellWithTitle:@"" imageUrl:_arr_dataSource[indexPath.section][indexPath.row]];
            
            return cell;
        }


    
    if (indexPath.section == 3) {
       
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoExitLoginTableViewCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoDefaultCell" forIndexPath:indexPath];
        
        NSDictionary *cellDict = [[_arr_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:[cellDict objectForKey:@"itemTitle"]];
        [cell.detailTextLabel setText:[cellDict objectForKey:@"itemValue"]];
        return cell;
    }

    return nil;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    
    WEAKSELF
    
    switch (indexPath.section) {
        case 0:
        {
            //点击头像
            MoudleFourthUserInfoAvatarCell *cell = (MoudleFourthUserInfoAvatarCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            [self imageByCameraAndPhotosAlbumWithActionSheetUsingBlock:^(UIImage *image, NSString *imageName, NSString *imagePath) {
                [cell action_setImage:image];
                weakSelf.avatarImage = image;
                
                //**更新头像操作
                
                //[weakSelf action_saveData];
            }];
        }
            break;
        case 1:{
            
            switch (indexPath.row) {
                case 0:{
                    pushViewControllerWith(sbStoryBoard_Moudle_UserCenter, EditPhoneVeriferPwdViewController, nil);
                }
                    
                    break;
                case 1:{
                    pushViewControllerWith(sbStoryBoard_Moudle_UserCenter, UserCenterCardVerifierViewController, nil);
                }
                    
                    break;
                
            }
            
        }
            break;
        case 2:{
            pushViewControllerWith(sbStoryBoard_Moudle_UserCenter, EditPhoneNewPwdViewController, nil);
        }
            break;
        case 3:{
            //退出登录
            [UIAlertView showAlertViewWithTitle:@"退出登录"
                                        message:@"你确定要退出当前账号吗?"
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@[@"确定"]
                                      onDismiss:^(int buttonIndex) {
                                          [CommonUser userLogout];
                                      } onCancel:nil];
            

        }
            break;
            
              }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setViewTitle:@"账号设置"];
    
    mRegisterNib_TableView(_tbv_UserInfoTableView, NSStringFromClass([MoudleFourthUserInfoAvatarCell class]));
    
    mRegisterHeaderFooterNib_TableView(_tbv_UserInfoTableView, NSStringFromClass([UserInfoHeaderFooterView class]));
    
    self.arr_dataSource = @[@[@"userUrl"],
                            @[@{@"itemTitle":@"手机号码",@"itemValue":@"15618297762"},@{@"itemTitle":@"身份认证",@"itemValue":@"立即开户"}],
                            @[@{@"itemTitle":@"修改登录密码",@"itemValue":@""}],
                            @[@{@"itemTitle":@"退出登录",@"itemValue":@""}]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
