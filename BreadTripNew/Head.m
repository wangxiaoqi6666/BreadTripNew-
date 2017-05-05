//
//  Head.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/10.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "Head.h"

@implementation Head


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews {
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(34.5, -21, 16, 16)];
    vv.layer.cornerRadius = 8;
    vv.layer.masksToBounds = YES;
    vv.backgroundColor = [UIColor whiteColor];
    vv.layer.borderWidth = 4;
    vv.layer.borderColor = [UIColor colorWithRed:205/255.0 green:170/255.0 blue:125/255.0 alpha:1].CGColor;
    [self addSubview:vv];
    
    UIView *vv2 = [[UIView alloc] initWithFrame:CGRectMake(40, -8, 5, 18.5)];
    vv2.backgroundColor = [UIColor colorWithRed:205/255.0 green:170/255.0 blue:125/255.0 alpha:1];
    [self addSubview:vv2];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(60, -23.5, 200, 20)];
    _label.textColor = [UIColor colorWithRed:205/255.0 green:170/255.0 blue:125/255.0 alpha:1];
//    label.text = @"第2天 2016.08.08";
    _label.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.label];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
