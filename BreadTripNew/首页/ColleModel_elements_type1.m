
//
//  ColleModel_elements_type1.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/6.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "ColleModel_elements_type1.h"

@implementation ColleModel_elements_type1

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dictionary{
    return [[ColleModel_elements_type1 alloc] initWithDic:dictionary];
}

@end
