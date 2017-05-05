//
//  DetailTableViewCell.m
//  DetailTableDemo
//
//  Created by 王小琪 on 17/1/8.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "DetailTableViewCell.h"
#import <SDAutoLayout.h>
#import <UIImageView+WebCache.h>
#import "UILabel+width.h"
#import "EffectView.h"
@interface DetailTableViewCell()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *contentlabel;
@property (nonatomic, strong) UILabel *datelabel;
@property (nonatomic, strong) UILabel *locallabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) EffectView *effV;

@end


@implementation DetailTableViewCell
// 改变单元格的大小
- (void)setFrame:(CGRect)frame {
    frame.origin.x += 20;
    frame.size.width -= 40;
    frame.size.height -= 20;
    [super setFrame:frame];
}
// 单元格分割线宽度
- (void)drawRect:(CGRect)rect {
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    // 定义分割线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:210/250.0 alpha:0.9].CGColor);
    CGContextSetLineWidth(context, 5);
    // 定义分割线的坐标
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 5));
    
    // 画图片底部的尖角线
//    [self drawTriRect];
}
- (void)drawTriRect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.imageV.size.height-5)];
    [path addLineToPoint:CGPointMake(0, self.imageV.size.height)];
    [path addLineToPoint:CGPointMake(15, self.imageV.size.height)];
    [path addLineToPoint:CGPointMake(10, self.imageV.size.height-5)];
    
    [path closePath];
    [path moveToPoint:CGPointMake(15, self.imageV.size.height)];
    [path addLineToPoint:CGPointMake(self.imageV.frame.size.width, self.imageV.size.height)];
    [path addLineToPoint:CGPointMake(self.imageV.frame.size.width ,self.imageV.size.height-5)];
    [path addLineToPoint:CGPointMake(20, self.imageV.size.height-5)];
    [path closePath];
    path.lineWidth = 2;
    UIColor *fillcolor = [UIColor greenColor];
    [fillcolor set];
    [path fill];
    // 根据我们设置的各个点连线
    [path stroke];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageV];
        
        _effV = [[EffectView alloc] init];
        _effV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.effV];
        
        _contentlabel = [[UILabel alloc] init];
        _contentlabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.contentlabel];
        
        _datelabel = [[UILabel alloc] init];
        _datelabel.textColor = [UIColor grayColor];
        _datelabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.datelabel];
        
        _locallabel = [[UILabel alloc] init];
        _locallabel.backgroundColor = [UIColor colorWithWhite:230/250.0 alpha:1];
        _locallabel.layer.cornerRadius = 10;
        _locallabel.layer.masksToBounds = YES;
        _locallabel.textColor = [UIColor colorWithRed:67/250.0 green:205/25.0 blue:128/250.0 alpha:1];
        _locallabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.locallabel];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithRed:205/255.0 green:170/255.0 blue:125/255.0 alpha:1];
        [self.contentView addSubview:self.line];
        
    }return self;
}

-(void)setWays:(DetailModel_days_waypoints *)ways {
    _ways = ways;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_ways.photo_weblive] placeholderImage:[UIImage imageNamed:@"beauti"]];
    _contentlabel.text = _ways.text;
    _datelabel.text = [NSString stringWithFormat:@"🕒%@",_ways.local_time];
    _locallabel.text = @"丹麦。哥本哈根";
    
    // 计算图片的宽高比
    CGFloat hei = [self.ways.photo_info.h floatValue];
    CGFloat wid = [self.ways.photo_info.w floatValue];
    CGFloat bili = 0;
    if (wid != 0) {
        bili = (hei / wid )*([UIScreen mainScreen].bounds.size.width-40);
    }
    
    // 计算locallabel的宽度自适应
    _locallabel.font = [UIFont systemFontOfSize:13];
    CGFloat width = [UILabel getWidthWithTitle:self.locallabel.text font:self.locallabel.font];
    
    // 适配
    _imageV.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).heightIs(bili);
    _effV.sd_layout.topSpaceToView(_imageV,-10).rightEqualToView(_imageV).leftEqualToView(_imageV).heightIs(30);
    _contentlabel.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).topSpaceToView(_imageV,1).autoHeightRatio(0);
    _datelabel.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(_contentlabel,20).heightIs(20).widthIs(170);
    _locallabel.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(_contentlabel,20).heightIs(20).widthIs(width+20);
    _line.sd_layout.leftSpaceToView(self.contentView,20).bottomSpaceToView(self.contentView,-20.5).widthIs(5).heightIs(20.5);


    [self setupAutoHeightWithBottomView:_locallabel bottomMargin:30];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
