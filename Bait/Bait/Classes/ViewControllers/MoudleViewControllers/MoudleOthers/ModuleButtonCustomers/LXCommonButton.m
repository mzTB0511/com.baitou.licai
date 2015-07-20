//
//  LXCommonButton.m
//  Bait
//
//  Created by 刘轩 on 15/7/21.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "LXCommonButton.h"

@implementation LXCommonButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    
    UIImage *img_Nomal = [[UIImage imageNamed:@"btn_common_button_nomal"] stretchableImageWithLeftCapWidth:27 topCapHeight:0];
    
    UIImage *img_Sel = [[UIImage imageNamed:@"btn_common_button_nomal_sel"] stretchableImageWithLeftCapWidth:27 topCapHeight:0];
    
    UIImage *img_Disnable = [[UIImage imageNamed:@"btn_common_button_nomal_disable"] stretchableImageWithLeftCapWidth:27 topCapHeight:0];

    
    [self setBackgroundImage:img_Nomal forState:UIControlStateNormal];
    [self setBackgroundImage:img_Sel forState:UIControlStateHighlighted];
    [self setBackgroundImage:img_Disnable forState:UIControlStateDisabled];
    
}

@end
