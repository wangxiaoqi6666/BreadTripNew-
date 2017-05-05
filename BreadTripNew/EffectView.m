//
//  EffectView.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/11.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "EffectView.h"

@implementation EffectView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(10, 0)];
    [path addLineToPoint:CGPointMake(16, 6)];
    [path addLineToPoint:CGPointMake(22, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width,0)];
    [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
    [path addLineToPoint:CGPointMake(0, rect.size.height)];
    [path closePath];
    UIColor *fillcolor = [UIColor whiteColor];
    [fillcolor set];
    [path fill];
    // 根据我们设置的各个点连线
    [path stroke];

}


@end
