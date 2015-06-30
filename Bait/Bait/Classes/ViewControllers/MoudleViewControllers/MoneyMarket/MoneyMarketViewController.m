//
//  MoudleSecondViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketViewController.h"
#import "MoneyMarketContainerViewController.h"


@interface MoneyMarketViewController ()

@property (nonatomic, weak) MoneyMarketContainerViewController *containerViewController;


@end

@implementation MoneyMarketViewController



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

- (IBAction)swapButtonPressed:(id)sender
{
    NSString *suIdentifer;
    UISegmentedControl *sgcControle = (UISegmentedControl *)sender;
    switch (sgcControle.selectedSegmentIndex) {
        case 0:
            suIdentifer = SegueIdentifierFirst;
            break;
        case 1:
            suIdentifer = SegueIdentifierSecond;
            break;
        case 2:
            suIdentifer = SegueIdentifierThird;
            break;
            
        default:
            break;
    }
    
    
    [self.containerViewController swapViewToViewControllerWithIdentifier:suIdentifer];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTitle:@"理财超市"];
    
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
