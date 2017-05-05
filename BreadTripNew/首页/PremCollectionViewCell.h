//
//  PremCollectionViewCell.h
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/26.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColleModel.h"

@interface PremCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ColleModel_elements_data *model;
@property (nonatomic, strong) UIImageView *button;

@property (nonatomic, copy) void (^tapActionBlock)(NSInteger user_id);

@end
