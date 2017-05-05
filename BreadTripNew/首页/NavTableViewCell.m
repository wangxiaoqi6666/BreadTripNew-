//
//  NavTableViewCell.m
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/27.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import "NavTableViewCell.h"

@implementation NavTableViewCell
+ (id)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"tags";
    NavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NavTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setTagsFrame:(TagsFrame *)tagsFrame
{
    _tagsFrame = tagsFrame;
    
    for (NSInteger i=0; i<tagsFrame.tagsArray.count; i++) {
        
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagsBtn setTitle:tagsFrame.tagsArray[i] forState:UIControlStateNormal];
        [tagsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        tagsBtn.titleLabel.font = TagsTitleFont;
        
        tagsBtn.layer.borderWidth = 0.6;
        tagsBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tagsBtn.layer.cornerRadius = 20;
        tagsBtn.layer.masksToBounds = YES;
        
        tagsBtn.frame = CGRectFromString(tagsFrame.tagsFrames[i]);
        
        [self.contentView addSubview:tagsBtn];
    }
    
    
}
@end
