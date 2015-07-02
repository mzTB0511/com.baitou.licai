//
//  MoneyMarketContainerViewController.m
//  Bait
//
//  Created by 刘轩 on 15/6/30.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoneyMarketContainerViewController.h"
#import "MoneyMarketProductPTPViewController.h"
#import "MoneyMarketProductFundViewController.h"
#import "MoneyMarketFavouriteViewController.h"


@interface MoneyMarketContainerViewController ()

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) MoneyMarketProductPTPViewController *firstViewController;
@property (strong, nonatomic) MoneyMarketProductFundViewController *secondViewController;
@property (strong, nonatomic) MoneyMarketFavouriteViewController *thirdViewController;
@property (strong, nonatomic) UIViewController *curViewController;
@property (assign, nonatomic) BOOL transitionInProgress;

@end

@implementation MoneyMarketContainerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transitionInProgress = NO;
    self.currentSegueIdentifier = SegueIdentifierFirst;
    [self performSegueWithIdentifier:SegueIdentifierFirst sender:nil];
    [self performSegueWithIdentifier:SegueIdentifierSecond  sender:nil];
    [self performSegueWithIdentifier:SegueIdentifierThird sender:nil];
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:SegueIdentifierFirst]) {
        self.firstViewController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierSecond]) {
        self.secondViewController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierThird]) {
        self.thirdViewController = segue.destinationViewController;
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierFirst]) {
        // If this is not the first time we're loading this.
        
        // If this is the very first time we're loading this we need to do
        // an initial load and not a swap.
        [self addChildViewController:segue.destinationViewController];
        UIView* destView = ((UIViewController *)segue.destinationViewController).view;
        destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:destView];
        [segue.destinationViewController didMoveToParentViewController:self];
        
        _curViewController = self.firstViewController;
        
    }
    
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        // [toViewController didMoveToParentViewController:self];
        _curViewController = toViewController;
        self.transitionInProgress = NO;
        
    }];
}

- (void)swapViewToViewControllerWithIdentifier:(NSString *)indntifier
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.transitionInProgress) {
        return;
    }
    
    self.transitionInProgress = YES;
    self.currentSegueIdentifier = indntifier;
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierFirst]) && self.firstViewController) {
        [self swapFromViewController:_curViewController toViewController:self.firstViewController];
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierSecond]) && self.secondViewController) {
        [self swapFromViewController:_curViewController toViewController:self.secondViewController];
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierThird]) && self.thirdViewController) {
        [self swapFromViewController:_curViewController toViewController:self.thirdViewController];
        return;
    }
    
    
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
