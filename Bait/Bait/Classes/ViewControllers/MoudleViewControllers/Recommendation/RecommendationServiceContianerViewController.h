//
//  RecommendationServiceContianerViewController.h
//  Bait
//
//  Created by 刘轩 on 15/6/30.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SegueIdentifierActivity  @"segUserActivity"
#define SegueIdentifierMessage @"segUserMessage"


@interface RecommendationServiceContianerViewController : UIViewController

- (void)swapViewToViewControllerWithIdentifier:(NSString *)indntifier;


@end
