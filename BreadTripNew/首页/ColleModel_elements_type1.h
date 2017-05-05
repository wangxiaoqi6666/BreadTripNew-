//
//  ColleModel_elements_type1.h
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/6.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColleModel_elements_type1 : NSObject

@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *html_url;

+ (instancetype)modelWithDic:(NSDictionary *)dictionary;

@end
