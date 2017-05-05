//
//  PremModel.m
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/26.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import "PremModel.h"


@implementation PremModel
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }return self;
}

- (void)setSearch_data:(NSArray *)search_data {
    _search_data = search_data;
    NSMutableArray *arr = @[].mutableCopy;
    for (id dic in _search_data) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            PremModel_search_data *seadata = [[PremModel_search_data alloc] initWithDictionary:dic];
            [arr addObject:seadata];
        }
    }_search_data = arr.copy;
}

@end


@implementation PremModel_search_data

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setElements:(NSArray *)elements {
    _elements = elements;
    NSMutableArray *eleme = @[].mutableCopy;
    for (id dic in _elements){
        if ([dic isKindOfClass:[NSDictionary class]]) {
            PremModel_search_data_elements *dataelem = [[PremModel_search_data_elements alloc] initWithDictionary:dic];
            [eleme addObject:dataelem];
        }
    }_elements = eleme.copy;
}
@end

@implementation PremModel_search_data_elements
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id_id"]) {
        [self setValue:value forKey:@"id_id"];
    }
}


@end

