//
//  DetailModel.m
//  DetailTableDemo
//
//  Created by 王小琪 on 17/1/7.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"lastid": @"id",@"descriptions":@"description"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"days": [DetailModel_days class]};
}

@end

@implementation DetailModel_days
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"waypoints": [DetailModel_days_waypoints class]};
}
@end

@implementation DetailModel_days_waypoints
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myid": @"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"location": [DetailModel_days_waypoints_location class],@"photo_info": [DetailModel_days_waypoints_photoinfo class]};
}
@end

@implementation DetailModel_days_waypoints_photoinfo

@end
@implementation DetailModel_days_waypoints_location

@end
