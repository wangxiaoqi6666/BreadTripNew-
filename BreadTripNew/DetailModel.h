//
//  DetailModel.h
//  DetailTableDemo
//
//  Created by 王小琪 on 17/1/7.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@class DetailModel_days;
@class DetailModel_days_waypoints;
@class DetailModel_days_waypoints_photoinfo;
@class DetailModel_days_waypoints_location;

@interface DetailModel : NSObject
@property (nonatomic, assign) NSNumber *target_waypoint_id;
@property (nonatomic, strong) NSArray *covered_countries;// 可以以后解 是国家国旗图片
@property (nonatomic, assign) NSNumber *waypoints;
@property (nonatomic, assign) BOOL wifi_sync;
@property (nonatomic, strong) NSString *last_day;
@property (nonatomic, strong) NSDictionary *poi_infos_count;// 白色区域里的经典住宿0
@property (nonatomic, strong) NSString *first_day;
@property (nonatomic, assign) NSNumber *lastid;
@property (nonatomic, assign) NSString *city;
@property (nonatomic, assign) NSNumber *privacy;
@property (nonatomic, assign) NSNumber *day_count;// 三个格里的几天
@property (nonatomic, strong) NSString *first_timezone;
@property (nonatomic, assign) NSNumber *comment_count;
@property (nonatomic, assign) NSNumber *shared;
@property (nonatomic, strong) NSArray *tips;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, assign) NSNumber *mileage;// 里程需要取整数
@property (nonatomic, strong) NSString *descriptions;// 改下
@property (nonatomic, assign) NSNumber *view_count;
@property (nonatomic, strong) NSArray *city_slug_urls;
@property (nonatomic, assign) NSNumber *last_modified;
@property (nonatomic, strong) NSDictionary *user;//用户信息
@property (nonatomic, assign) NSNumber *date_complete;
@property (nonatomic, assign) NSNumber *device;
@property (nonatomic, assign) NSNumber *date_added;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSString *trackpoints_thumbnail_image;// 头上地图
@property (nonatomic, strong) NSString *name;// 大标题
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSArray *days;// 解析这个天数
@property (nonatomic, assign) NSNumber *recommendations;
@property (nonatomic, strong) NSString *cover_image;
@property (nonatomic, strong) NSDictionary *start_point;
@property (nonatomic, assign) BOOL recommended;

@end

// 现在只解析day下面的 用于表格单元格展示
@interface DetailModel_days : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSNumber *day;
@property (nonatomic, strong) NSArray *waypoints;
@end


@interface DetailModel_days_waypoints : NSObject
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *photo_1600;
@property (nonatomic, strong) NSString *poi;
@property (nonatomic, strong) NSDictionary *video;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, assign) NSNumber *trip_id;
@property (nonatomic, assign) NSNumber *myid;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) NSNumber *privacy;
@property (nonatomic, assign) NSNumber *comments;
@property (nonatomic, assign) BOOL recommended;
@property (nonatomic, strong) NSString *photo_webtrip;
@property (nonatomic, strong) DetailModel_days_waypoints_location *location;// 地理位置的经度纬度
@property (nonatomic, strong) NSString *text;// 单元格文字
@property (nonatomic, strong) NSString * photo_weblive;// 单元格图片
@property (nonatomic, assign) NSNumber *shared;
@property (nonatomic, assign) NSString *province;
@property (nonatomic, strong) NSString *photo_s;
@property (nonatomic, assign) BOOL track;
@property (nonatomic, strong) NSString *hotel;
@property (nonatomic, assign) NSNumber *device;
@property (nonatomic, assign) NSNumber *date_added;
@property (nonatomic, assign) NSNumber *day;//第几天
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) BOOL cover;
@property (nonatomic, strong) NSString * photo_w640;
@property (nonatomic, strong) DetailModel_days_waypoints_photoinfo * photo_info;// 单元格图片的宽高
@property (nonatomic, strong) NSDictionary * place;
@property (nonatomic, strong) NSString * local_time;// 单元格左下角时间
@property (nonatomic, assign) NSNumber * recommendations;
@property (nonatomic, strong) NSString * model;
@end

// 单元格图片的宽高
@interface DetailModel_days_waypoints_photoinfo : NSObject
@property (nonatomic, assign) NSNumber * h;// 高
@property (nonatomic, assign) NSNumber * w;//宽
@end

@interface DetailModel_days_waypoints_location : NSObject
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;

@end

