//
//  ColleModel.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/6.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "ColleModel.h"

@implementation ColleModel

@end

@implementation ColleModel_main
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"elements" : [ColleModel_elements class]};
}

@end


@implementation ColleModel_elements
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    
    return @{@"data": [ColleModel_elements_data class]};
}

@end

//@implementation ColleModel_elements_type1
//
//@end

@implementation ColleModel_elements_data
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_id":@"id",@"defaultt":@"default",@"descriptionn":@"description"};
}

@end

@implementation ColleModel_elements_data_user
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userid" : @"id"};
}
@end
