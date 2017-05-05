//
//  MyReusableView.h
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/26.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
@interface MyReusableView : UICollectionReusableView<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *scrollView;
@end
