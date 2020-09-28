//
//  BaiduMapManager.h
//  ChaZX
//
//  Created by dede wang on 2019/11/1.
//  Copyright © 2019 周家康. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

#define BAIDU_MAP_AK @"S4WsK3Wqh8mGpNSOLkR5OEHPly7acefX"
#define NOTNIL(v) (v?v:@"")
#define ws(object) __weak typeof (object) weakSelf = object
#define JKUserDefaults [NSUserDefaults standardUserDefaults]


NS_ASSUME_NONNULL_BEGIN

@interface BaiduMapManager : NSObject<BMKGeneralDelegate, BMKGeoCodeSearchDelegate, BMKLocationManagerDelegate, BMKLocationAuthDelegate, BMKDistrictSearchDelegate>

+ (instancetype)sharedManager;
- (void) setUpData;

@property (nonatomic, strong) BMKMapManager * mapManager;
@property (nonatomic, strong) BMKGeoCodeSearch * geoCodeSearch;
@property (nonatomic, strong) BMKPoiSearch *poiSearch;
@property (nonatomic, strong) BMKLocationManager *locationManager; //定位对象
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置对象

@property (nonatomic, strong) NSString * province;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * district;
@property (nonatomic, strong) NSString * addressDetail;

@property (nonatomic, copy) void (^locationSuccess)(void);

// 根据城市名称， 区名称 找出区政府区域中心的坐标
- (void) handleCityCoordinate:(NSString*) cityName
              andDistrictName: (NSString*) districtName;

// 根据一个坐标，找出该坐标附近的10个地址。
- (void) handleScopeCoordinate: (CLLocationCoordinate2D) point;

// 根据城市名字，具体街道名称找到该地址的坐标
- (void) handleCityCoordinate:(NSString*) cityName
                   andAddress: (NSString*) address;

@property (nonatomic, copy) void (^addressSuccess)(CGFloat lat, CGFloat lng);
@property (nonatomic, copy) void (^transformSuccess)(CGFloat lat, CGFloat lng);
@property (nonatomic, copy) void (^scopTransformSuccess)(NSArray * array);

- (void) startUpdatingLocation;


@end

NS_ASSUME_NONNULL_END
