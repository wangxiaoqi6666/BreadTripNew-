//
//  HeaderView.h
//  DetailTableDemo
//
//  Created by 王小琪 on 17/1/8.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@interface HeaderView : UIView
@property (nonatomic, strong) DetailModel *detailmodel;
@property (nonatomic, strong) UILabel *userlab;
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, assign) CGFloat height;
@end
