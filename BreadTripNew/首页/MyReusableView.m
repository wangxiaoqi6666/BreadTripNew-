//
//  MyReusableView.m
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/26.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import "MyReusableView.h"
#import "UIViewExt.h"
@implementation MyReusableView
- (SDCycleScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 10, self.width-20, 210) delegate:self placeholderImage:[UIImage imageNamed:@"beauti"]];
        
        _scrollView.autoScrollTimeInterval = 4.0f;
        _scrollView.layer.cornerRadius = 5;
        _scrollView.layer.masksToBounds = YES;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}


@end
