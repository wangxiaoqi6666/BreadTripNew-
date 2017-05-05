//
//  PremModel.h
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/26.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PremModel_search_data;
@class PremModel_search_data_elements;

//@interface PremModel : NSObject
//@property (nonatomic) NSInteger status;
//@property (nonatomic) NSString *message;
//@property (nonatomic) PremModel_data*data;
//@end
@interface PremModel : NSObject
@property (nonatomic) NSArray *search_data;
@property (nonatomic) NSString *date_time;
@property (nonatomic) NSArray *elements;
@property (nonatomic) NSNumber *next_start;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

@interface PremModel_search_data : NSObject
@property (nonatomic) NSArray *elements;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *title;// 标题是：国外/内热门目的地
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

@interface PremModel_search_data_elements : NSObject
@property (nonatomic) NSNumber * rating;
@property (nonatomic) NSString *name; // 城市名
@property (nonatomic) NSString *url; // 拼接url点击链接
@property (nonatomic) NSNumber * wish_to_go_count;//喜欢
@property (nonatomic) NSString *name_orig;                                                                                                                                                                                                                                                   @property (nonatomic) NSNumber * visited_count;//去过
@property (nonatomic) NSNumber * comments_count;
@property (nonatomic) NSDictionary *location;
@property (nonatomic) BOOL has_experience;
@property (nonatomic) NSNumber * rating_users;
@property (nonatomic) NSString *name_zh;
@property (nonatomic) NSString *name_en;
@property (nonatomic) NSString *slug_url;
@property (nonatomic) NSNumber * type;
@property (nonatomic) NSNumber *id_id;
@property (nonatomic) BOOL has_route_maps;
@property (nonatomic) NSString *icon;

- (instancetype)initWithDictionary:(NSDictionary *)dic;



@end

