//
//  UserInfo.h
//  BabySante
//
//  Created by dd on 15/4/15.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfo : BaseModel

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *member_id;

/**
 *  用户手机号
 */
@property (nonatomic, copy) NSString *user_phone;

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *user_ico;

/**
 *  认证用户名称
 */
@property (nonatomic, copy) NSString *member_name;

/**
 *  用户银行卡
 */
@property (nonatomic, copy) NSString *member_card;


// 用户设备唯一标示 UnionID
@property(nonatomic,strong) NSString* unionID;


// 个推唯一标示ID userID
@property(nonatomic,strong) NSString* gtClientID ;



@end
