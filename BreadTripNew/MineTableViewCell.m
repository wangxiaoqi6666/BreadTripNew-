//
//  MineTableViewCell.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/3.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)drawRect:(CGRect)rect {
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    // 定义分割线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:200/250.0 alpha:1].CGColor);
    CGContextSetLineWidth(context, 2);
    // 定义分割线的坐标
    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
