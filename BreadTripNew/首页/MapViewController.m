//
//  MapViewController.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/11.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
@interface MapViewController ()<MKMapViewDelegate>
{
    UISegmentedControl *segm;
    MKMapView *mapV;
    CLGeocoder *geocoder;
    MKPolyline *routeLine;
    NSMutableArray *pointsarr;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pointsarr = [[NSMutableArray alloc] init];
    // 导航栏分段控件
    segm = [[UISegmentedControl alloc] initWithItems:@[@"地图",@"卫星"]];
    segm.tintColor = [UIColor whiteColor];
    segm.backgroundColor = [UIColor colorWithRed:222/250.0 green:184/250.0 blue:135/250.0 alpha:1];
    segm.layer.cornerRadius = 6;
    segm.layer.masksToBounds = YES;
    segm.frame = CGRectMake(0, 0, 150, 40);
    [segm addTarget:self action:@selector(segmClick) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segm];
    // 地图
    mapV = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mapV.delegate=self;
    self.view = mapV;
    
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[self.latiarr.count];
    // 遍历数组添加位置
    for (int i = 0; i < self.latiarr.count; i++) {
        
        // 添加锚点
        MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coo={[self.latiarr[i] floatValue],[self.lonarr[i] floatValue]};
        annot.coordinate=coo;
        // 添加锚点和精确度
        [mapV addAnnotation:annot];
        MKCoordinateRegion region = {coo, MKCoordinateSpanMake(40, 10)};
        [mapV setRegion:region animated:YES];
        
        commonPolylineCoords[i] = coo;
    }
    //构造折线对象
    MKPolyline *commonPolyline = [MKPolyline polylineWithCoordinates:commonPolylineCoords count:self.latiarr.count];
    
    //在地图上添加折线对象
    [mapV addOverlay: commonPolyline];


    
}
- (void)segmClick {
    NSInteger index = segm.selectedSegmentIndex;
    switch (index) {
        case 0:
            mapV.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapV.mapType = MKMapTypeSatellite;
            break;

        default:
            break;
    }
}

// 修改锚点样式
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // 自定义锚点样式
    static NSString *reuse=@"annotate";
    MKAnnotationView *annot=[mapView dequeueReusableAnnotationViewWithIdentifier:reuse];
    if (!annot) {
        annot = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuse];
    }
    annot.image=[UIImage imageNamed:@"定位-2"];
    annot.canShowCallout=YES;
    
    return annot;
}
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(nonnull id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *lineview=[[MKPolylineView alloc] initWithOverlay:overlay];
        lineview.strokeColor=[[UIColor colorWithRed:0/250.0 green:191/250.0 blue:255/250.0 alpha:1] colorWithAlphaComponent:0.8];
        lineview.lineWidth=6.0;
        return lineview;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
