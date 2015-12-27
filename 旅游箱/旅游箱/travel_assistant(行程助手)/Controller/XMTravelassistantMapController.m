//
//  XMTravelassistantMapController.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantMapController.h"
#import "XMAnnotation.h"
#import "UIBarButtonItem+XM.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface XMTravelassistantMapController ()<MKMapViewDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
/** 反地理编码*/
@property (nonatomic,strong) CLGeocoder *geocoder;
/** 地图*/
@property (nonatomic,weak) MKMapView *mapView;
/** 大头针模型*/
@property (nonatomic,strong) XMAnnotation *annotation;
/** 记录用户当前位置*/
@property (nonatomic,copy) NSString * userLocation;
/** 记录当前选中的位置*/
@property (nonatomic,copy) NSString * selectPlace;
@end

@implementation XMTravelassistantMapController
-(CLLocationManager *)manager
{
    if (!_manager) _manager = [[CLLocationManager alloc] init];
    return _manager;
}
-(CLGeocoder *)geocoder
{
    if (!_geocoder) _geocoder = [[CLGeocoder alloc] init];
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"获取位置";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"account_page_title_right_finish"] selectorImg:[UIImage imageNamed:@"account_page_title_right_finish_press"] target:self action:@selector(rightBarButtonItemClick)];
    
    //授权
    [self.manager requestAlwaysAuthorization];
    //添加mapView
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView = mapView;
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    //给mapView设置手势处理
    [mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapViewClick:)]];
}

/**
 *  点击导航右边按钮
 */
-(void)rightBarButtonItemClick
{
    //判断当前是否选中位置
    if ([self.delegate respondsToSelector:@selector(travelassistantMapSelectCity:)]) {
        if (self.selectPlace)
            [self.delegate travelassistantMapSelectCity:self.selectPlace];
        else
            [self.delegate travelassistantMapSelectCity:self.userLocation];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  当用户的位置更新，就会调用（不断地监控用户的位置，调用频率特别高）
 *
 *  @param userLocation 表示地图上蓝色那颗大头针的数据
 */
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    // 设置地图的中心点（以用户所在的位置为中心点）
    [mapView setCenterCoordinate:center animated:YES];
    // 反地理编码获取用户位置并设置标题
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        userLocation.title = placeMark.locality;
        userLocation.subtitle = placeMark.name;
        self.userLocation = placeMark.name;
    }];
    
    // 设置地图的显示范围
    MKCoordinateSpan span = MKCoordinateSpanMake(5, 5);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [mapView setRegion:region animated:YES];
}

/**
 *  点击mapView时调用
 */
-(void)mapViewClick:(UITapGestureRecognizer *)tap
{
    //获取用户在mapView点的位置
    CGPoint point = [tap locationInView:tap.view];
    //将坐标转化为经纬度
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    //包装位置对象
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    NSLog(@"%f-------%f",coordinate.latitude,coordinate.longitude);
    //创建大头针
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"点击的位置有误");
        } else {
            CLPlacemark *placemark = [placemarks firstObject];
            //移走前一个大头针
            if (self.annotation) {
                [self.mapView removeAnnotation:self.annotation];
            }
    
            //创建大头针模型
            XMAnnotation *annotation = [[XMAnnotation alloc] init];
            self.annotation = annotation;
            annotation.coordinate = coordinate;
            annotation.title = placemark.locality;
            annotation.subtitle = placemark.name;
            annotation.icon = @"map_page_d0";
            [self.mapView addAnnotation:annotation];
            
            self.selectPlace = placemark.name;
        }
    }];
}
/**
 *  添加大头针时调用
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
   
    static NSString *annotationId = @"annotationId";
    if (![annotation isKindOfClass:[XMAnnotation class]]) return nil;
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationId];
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationId];
        //显示标题和子标题
        annotationView.canShowCallout = YES;
        // 设置大头针描述的偏移量
        annotationView.calloutOffset = CGPointMake(0, -10);
    }
    // 传递模型
    annotationView.annotation = annotation;
    //设置图片
    XMAnnotation *locationAnno = annotation;
    annotationView.image = [UIImage imageNamed:locationAnno.icon];
    return annotationView;
}

@end
