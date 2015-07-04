//
//  FormatData.m
//  请求下来的数据转化成数据对象
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//
#import "CommonFunc.h"
#import "FormatData.h"


static FormatData *fdata;

@implementation FormatData

+ (id)shareInstance
{
    
//    static FormatData *instance = nil;
    static dispatch_once_t pred;
	if(fdata == nil)
	{
     dispatch_once(&pred, ^{  //单例
		fdata = [[self alloc] init];
//        instance = [[self alloc] initFormmatData];
	  });
    }
	return fdata;
}

//+ (id)shareInstance
//{
//    static dispatch_once_t pred;
//    static FormatData *instance = nil;
//    dispatch_once(&pred, ^{
//        instance = [[self alloc] initFormmatData];
//    });
//    return instance;
//}

- (id)initFormmatData{
    self  = [super init];
    if (self == [super init]){
        
    }
    return self;
}

//
//
///*请求下来的数据封装成食物营养含量模块数据*/
//- (NSMutableArray *)formatDictToFoodNutritionTotalData:(NSArray *)dictArray
//{
//    NSMutableArray *tempArray = [NSMutableArray array];
//    
//    for (int i = 0; i < [dictArray count]; i ++) {
//        FoodElementTotal *data = [[FoodElementTotal alloc]init];
//        
//        NSDictionary *dict = [dictArray objectAtIndex:i];
//        
//        data.neid= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"neid"]];
//        data.name= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"name"]];
//        data.unit= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"unit"]];
//        data.imgurl= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"imgurl"]];
//        data.value= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"value"]];
//    
//        [tempArray addObject:data];
//        
//    }
//    
//    return tempArray;
//}
//





@end
