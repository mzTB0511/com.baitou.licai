//
//  RecommendationServiceViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/30.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RecommendationServiceViewController.h"
#import "RecommendationServiceContianerViewController.h"


@interface RecommendationServiceViewController ()

@property (nonatomic, weak) RecommendationServiceContianerViewController *containerViewController;



@end

@implementation RecommendationServiceViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if ([segue.identifier isEqualToString:@"userServiceContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

- (IBAction)swapButtonPressed:(id)sender
{
    NSString *suIdentifer;
    UISegmentedControl *sgcControle = (UISegmentedControl *)sender;
    switch (sgcControle.selectedSegmentIndex) {
        case 0:
            suIdentifer = SegueIdentifierActivity;
            break;
        case 1:
            suIdentifer = SegueIdentifierMessage;
            break;
        default:
            break;
    }
    
    
    [self.containerViewController swapViewToViewControllerWithIdentifier:suIdentifer];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
