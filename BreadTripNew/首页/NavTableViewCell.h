//
//  NavTableViewCell.h
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/27.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsFrame.h"
@interface NavTableViewCell : UITableViewCell

+ (id)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) TagsFrame *tagsFrame;
@end
