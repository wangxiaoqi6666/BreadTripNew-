//
//  TableHeaderView.h
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/3.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"
@interface TableHeaderView : UIView
@property (nonatomic, strong) MineModel *model;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *namelab;
@end
