//
//  UILabel+width.m
//  DetailTableDemo
//
//  Created by 王小琪 on 17/1/10.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "UILabel+width.h"

@implementation UILabel (width)
// label控件根据文字自适应宽度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
