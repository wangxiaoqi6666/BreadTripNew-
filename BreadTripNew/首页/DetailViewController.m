//
//  DetailViewController.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/7.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "DetailViewController.h"
#import "BWGetRequest.h"
#import "DetailModel.h"
#import "DetailTableViewCell.h"
#import <SDAutoLayout.h>
#import <UIImageView+WebCache.h>
#import "HeaderView.h"
#import <Masonry.h>
#import "Head.h"
#import "MapViewController.h"


@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *latarr,*longarr;
}
@property (nonatomic) UITableView *tableView;
@property (nonatomic) DetailModel *model;
@property (nonatomic) HeaderView *headerV;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    latarr = [NSMutableArray array];
    longarr = [NSMutableArray array];
    
    // 导航返回按钮
    UIImage *image = [UIImage imageNamed:@"返回箭头-2"];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.headerV = [[HeaderView alloc] init];
    [_headerV.iconV sd_setImageWithURL:[NSURL URLWithString:self.usericon]];
    _headerV.userlab.text = [NSString stringWithFormat:@"by %@",self.username];
    [self configNetwork];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maptapClick)];
    [self.headerV.imageV addGestureRecognizer:tap];

}
- (void)configNetwork
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/?gallery_mode=1&sign=08194883aaf320088acb618f741188d8",self.lastid];
    NSLog(@"url=====%@",urlString);
    [BWGetRequest GetRequestDetailWithURL:urlString Params:nil success:^(id success) {
        self.model = success;
        
        _headerV.detailmodel = self.model;
        self.headerV.frame = CGRectMake(0, -self.headerV.height, [UIScreen mainScreen].bounds.size.width, self.headerV.height);
        _tableView.contentInset = UIEdgeInsetsMake(_headerV.height, 0, 0, 0);
        [self.tableView addSubview:_headerV];

        [self.tableView reloadData];
        
    } failure:^(id failure) {
        
    }];
}
#pragma mark UITableView-DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.days.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DetailModel_days *days = self.model.days[section];
    return days.waypoints.count;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    NSLog(@"hehe%lf",CGRectGetHeight(self.headerV.frame));
////    self.headerV.frame = CGRectMake(self.headerV.frame.origin.x, -scrollView.contentOffset.y-self.headerV.height, self.headerV.frame.size.width, self.headerV.height);
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    DetailModel_days *days = self.model.days[indexPath.section];
    //    DetailModel_days_waypoints *ways = days.waypoints[indexPath.row];
    cell.ways = days.waypoints[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailModel_days *days = self.model.days[indexPath.section];
    DetailModel_days_waypoints *ways = days.waypoints[indexPath.row];
     return [self.tableView cellHeightForIndexPath:indexPath model:ways keyPath:@"ways" cellClass:[DetailTableViewCell class] contentViewWidth: [UIScreen mainScreen].bounds.size.width-40];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    Head *hh = [[Head alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    
    DetailModel_days *days = self.model.days[section];
    hh.label.text = [NSString stringWithFormat:@"第%@天 %@",days.day,days.date];
    return hh;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)maptapClick {
    
    for (DetailModel_days *days in self.model.days) {
        for (DetailModel_days_waypoints *ways in days.waypoints) {
            DetailModel_days_waypoints_location *loca = ways.location;
            if (loca.lng && loca.lng != nil) {
                [latarr addObject:loca.lat];
                [longarr addObject:loca.lng];
            }
        }
    }
    // 去重
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    for (NSString *string in latarr) {
//        [dict setValue:string forKey:string];
//    }
//    NSArray *array1 = [dict allKeys];
//    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithCapacity:0];
//    for (NSString *string2 in longarr) {
//        [dictM setValue:string2 forKey:string2];
//    }
//    NSArray *array = [dictM allKeys];
//    NSLog(@"lat:%@,long:%@",array1,array);
//    NSLog(@"lat:%ld,long:%ld",array1.count,array.count);
    MapViewController *map = [[MapViewController alloc] init];
    map.latiarr = latarr;
    map.lonarr = longarr;
    [self.navigationController pushViewController:map animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
