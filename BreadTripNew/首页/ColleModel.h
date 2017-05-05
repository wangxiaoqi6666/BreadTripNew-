//
//  ColleModel.h
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/6.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@class ColleModel_main;
@class ColleModel_elements;
@class ColleModel_elements_data;
@class ColleModel_elements_data_user;
//@class ColleModel_elements_type1;

@interface ColleModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) ColleModel_main *data;

@end
@interface ColleModel_main : NSObject
@property (nonatomic, strong) NSArray *search_data;
@property (nonatomic, strong) NSString *date_time;
@property (nonatomic, strong) NSArray *elements;
@property (nonatomic, assign) NSInteger next_start;
@end

@interface ColleModel_elements : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *desc;

@end
// 如果是type1的话 那么data下级是如下
//@interface ColleModel_elements_type1 : NSObject
//
//@property (nonatomic, strong) NSString *platform;
//@property (nonatomic, strong) NSString *image_url;
//@property (nonatomic, strong) NSString *html_url;

//@end
// 如果type是4的话那么data下级是如下
@interface ColleModel_elements_data : NSObject

@property (nonatomic, strong) NSString *cover_image_default;
@property (nonatomic, assign) NSInteger waypoints;
@property (nonatomic, assign) BOOL wifi_sync;
@property (nonatomic, strong) NSString *last_day;
@property (nonatomic, assign) NSNumber * id_id;
@property (nonatomic, assign) NSInteger view_count;

@property (nonatomic, assign)NSInteger privacy;
@property (nonatomic, assign)NSInteger day_count;
@property (nonatomic, strong)NSString *index_title;
@property (nonatomic, assign)NSInteger comment_count;
@property (nonatomic, strong)NSString *share_url;
@property (nonatomic, assign)BOOL recommended;
@property (nonatomic, assign)NSInteger version;
@property (nonatomic, assign)NSInteger mileage;
@property (nonatomic, assign)NSInteger spot_count;
@property (nonatomic, assign)NSInteger last_modified;
@property (nonatomic, strong)NSString *descriptionn;
@property (nonatomic, strong)ColleModel_elements_data_user * user;
@property (nonatomic, strong)NSString *popular_place_str;
@property (nonatomic, assign)NSInteger date_complete;
@property (nonatomic, assign)NSInteger device;
@property (nonatomic, assign)NSInteger date_added;
@property (nonatomic, strong)NSString *cover_image_w640;

@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)BOOL defaultt;
@property (nonatomic, strong)NSDictionary *start_point;
@property (nonatomic, assign)NSString *summary;
@property (nonatomic, assign)BOOL is_hot_trip;
@property (nonatomic, strong)NSString *cover_image_1600;
@property (nonatomic, assign)NSInteger recommendations;
@property (nonatomic, strong)NSString *first_day;
@property (nonatomic, strong)NSString *cover_image;
@property (nonatomic, assign)BOOL is_featured_trip;

@end

@interface ColleModel_elements_data_user : NSObject
@property (nonatomic, strong)NSString *location_name;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)NSInteger resident_city_id;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, assign)NSInteger gender;
@property (nonatomic, strong)NSString *avatar_m;
@property (nonatomic, strong)NSString *cover;
@property (nonatomic, strong)NSString *custom_url;
@property (nonatomic, assign)NSInteger userid;
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *country_num;
@property (nonatomic, strong)NSString *avatar_s;

@property (nonatomic, strong)NSString *country_code;
@property (nonatomic, strong)NSString *email_verified;
@property (nonatomic, assign)BOOL is_hunter;
@property (nonatomic, assign)BOOL cdc2;
@property (nonatomic, strong)NSString *avatar_l;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *user_desc;
@property (nonatomic, strong)NSString *points;


@end

