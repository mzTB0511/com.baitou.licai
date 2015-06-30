//
//  MoneyMarketContainerViewController.h
//  Bait
//
//  Created by 刘轩 on 15/6/30.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RootViewController.h"


#define SegueIdentifierFirst  @"embedFirst"
#define SegueIdentifierSecond @"embedSecond"
#define SegueIdentifierThird  @"embedThird"

@interface MoneyMarketContainerViewController : RootViewController


- (void)swapViewToViewControllerWithIdentifier:(NSString *)indntifier;

@end
