//
//  TagsFrame.m
//  TagsDemo
//
//  Created by Administrator on 16/1/21.
//  Copyright © 2016年 Administrator. All rights reserved.
//
//  计算多个标签的位置
//  标签根据文字自适应宽度
//  每行超过的宽度平均分配给每个标签
//  每行标签左右对其



#import "TagsFrame.h"

@implementation TagsFrame

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setTagsArray:(NSArray *)tagsArray
{
    _tagsArray = tagsArray;
    _tagsFrames = [NSMutableArray array];
    _tagsMinPadding = 10;
    _tagsMargin = 10;
    _tagsLineSpacing = 10;

    CGFloat btnX = _tagsMargin;
    CGFloat btnW = 0;
    
    CGFloat nextWidth = 0;  // 下一个标签的宽度
    CGFloat moreWidth = 0;  // 每一行多出来的宽度
    
    /**
     *  每一行的最后一个tag的索引的数组和每一行多出来的宽度的数组
     */
    NSMutableArray *lastIndexs = [NSMutableArray array];
    NSMutableArray *moreWidths = [NSMutableArray array];
    
    for (NSInteger i=0; i<tagsArray.count; i++) {
        // 设置按钮的宽度
        btnW = [self sizeWithText:tagsArray[i] font:TagsTitleFont].width + 20 + _tagsMinPadding * 2;
        
        if (i < tagsArray.count-1) {
            nextWidth = [self sizeWithText:tagsArray[i+1] font:TagsTitleFont].width +20+ _tagsMinPadding * 2;
        }
        CGFloat nextBtnX = btnX + btnW + _tagsMargin ;
        // 如果下一个按钮，标签最右边则换行
        if ((nextBtnX + nextWidth) > (WIDTH - _tagsMargin )) {
            // 计算超过的宽度
            moreWidth = WIDTH - nextBtnX;
            
            [lastIndexs addObject:[NSNumber numberWithInteger:i]];
            [moreWidths addObject:[NSNumber numberWithFloat:moreWidth]];
            
            btnX = _tagsMargin;
        }else{
            btnX += (btnW + _tagsMargin);
        }
        // 如果是最后一个且数组中没有，则把最后一个加入数组
        if (i == tagsArray.count - 1) {
            if (![lastIndexs containsObject:[NSNumber numberWithInteger:i]]) {
                [lastIndexs addObject:[NSNumber numberWithInteger:i]];
                [moreWidths addObject:[NSNumber numberWithFloat:0]];
            }
        }
    }
    
    NSInteger location = 0;  // 截取的位置
    NSInteger length = 0;    // 截取的长度
    
    CGFloat tagW = 0;
    CGFloat tagH = 40;
    
    for (NSInteger i=0; i<lastIndexs.count; i++) {
        
        NSInteger lastIndex = [lastIndexs[i] integerValue];
        if (i == 0) {
            length = lastIndex + 1;
        }else{
            length = [lastIndexs[i] integerValue]-[lastIndexs[i-1] integerValue];
        }
        
        // 从数组中截取每一行的数组
        NSArray *newArr = [tagsArray subarrayWithRange:NSMakeRange(location, length)];
        location = lastIndex + 1;
        // 控件样式居中对齐
        CGFloat sumWidth = 0;
        for (NSInteger k = 0; k < newArr.count; k++) {
            // 这是计算文字按钮自己的宽度的 然后用它推断x位置
            tagW = [self sizeWithText:newArr[k] font:TagsTitleFont].width + 20+_tagsMinPadding * 2;
            // 计算出总和
            sumWidth += (tagW+_tagsMargin);
        }
        // 重新计算x点值
        CGFloat tagX = (WIDTH - sumWidth + _tagsMargin)/2;
        CGFloat tagY = _tagsLineSpacing + (_tagsLineSpacing + tagH) * i;
    
        for (NSInteger j=0; j<newArr.count; j++) {
            
            tagW = [self sizeWithText:newArr[j] font:TagsTitleFont].width + 20 + _tagsMinPadding * 2;
            
            CGRect btnF = CGRectMake(tagX, tagY, tagW, tagH);
            
            [_tagsFrames addObject:NSStringFromCGRect(btnF)];
            
            tagX += (tagW+_tagsMargin);
            
        }
    }
    
    _tagsHeight = (tagH + _tagsLineSpacing) * lastIndexs.count + _tagsLineSpacing;
    
}

/**
 *  单行文本数据获取宽高
 *
 *  @param text 文本
 *  @param font 字体
 *
 *  @return 宽高
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text sizeWithAttributes:attrs];
}

@end
