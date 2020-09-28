//
//  BaiduMapManager.m
//  ChaZX
//
//  Created by dede wang on 2019/11/1.
//  Copyright © 2019 周家康. All rights reserved.
//

#import "BaiduMapManager.h"

@implementation BaiduMapManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static BaiduMapManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[BaiduMapManager alloc] init];
    });
    return instance;
}

- (void) setUpData {
    
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:BAIDU_MAP_AK authDelegate:self];
    
    /** 百度地图 */
    self.mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [self.mapManager start:BAIDU_MAP_AK generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

#pragma mark - Lazy loading
- (BMKLocationManager *)locationManager {
    if (!_locationManager) {
        //初始化实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置delegate
        _locationManager.delegate = self;
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = YES;
        //设置是否允许后台定位
        _locationManager.allowsBackgroundLocationUpdates = NO;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

- (BMKUserLocation *)userLocation {
    if (!_userLocation) {
        //初始化BMKUserLocation类的实例
        _userLocation = [[BMKUserLocation alloc] init];
    }
    return _userLocation;
}


#pragma mark -- 百度地图联网成功
- (void)onGetNetworkState:(int)iError {
    if (0 == iError) {
        NSLog(@"百度地图联网成功");
    } else {
        NSLog(@"onGetNetworkState %d",iError);
    }
}

#pragma mark -- 百度地图授权成功
- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        NSLog(@"百度地图授权成功");
    } else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

#pragma mark - BMKLocationManagerDelegate
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    if (0 == iError) {
        NSLog(@"百度定位授权成功");
    } else {
        NSLog(@"onCheckPermissionState %ld",(long)iError);
    }
}




/**
 @brief 当定位发生错误时，会调用代理的此方法
 @param manager 定位 BMKLocationManager 类
 @param error 返回的错误，参考 CLError
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error {
    NSLog(@"定位失败");
}

/**
 @brief 该方法为BMKLocationManager提供设备朝向的回调方法
 @param manager 提供该定位结果的BMKLocationManager类的实例
 @param heading 设备的朝向结果
 */
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    if (!heading) {
        return;
    }
    NSLog(@"用户方向更新");
    self.userLocation.heading = heading;
}

/**
 @brief 连续定位回调函数
 @param manager 定位 BMKLocationManager 类
 @param location 定位结果，参考BMKLocation
 @param error 错误信息。
 */
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error) {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    }
    if (!location) {
        return;
    }
    
    if (location.location) {
        NSLog(@"LOC = %@",location.location);
    }
    if (location.rgcData) {
        NSLog(@"rgc = %@",[location.rgcData description]);
    }
    NSLog(@"用户位置更新");
    self.userLocation.location = location.location;

    if( self.userLocation.location.coordinate.longitude < 0.00001 && self.userLocation.location.coordinate.latitude < 0.00001 ) {
        
    } else {
        [self.locationManager stopUpdatingLocation];
        [self setUpAddress:location.rgcData];
        if (self.locationSuccess) {
            self.locationSuccess();
        }
    }
    

}

- (void)setUpAddress :(BMKLocationReGeocode *) rgcModel {
    //省
    if ([rgcModel.province hasSuffix:@"省"]) {
        self.province = [rgcModel.province substringToIndex:rgcModel.province.length - 1];
    } else if ([rgcModel.province hasSuffix:@"市"]) {
        self.province = [rgcModel.province substringToIndex:rgcModel.province.length - 1];
    } else if ([rgcModel.province hasSuffix:@"自治区"]) {
        if ([rgcModel.province hasPrefix:@"内蒙古"]) {
            self.province = [rgcModel.province substringToIndex:3];
        } else {
            self.province = [rgcModel.province substringToIndex:2];
        }
    } else if ([rgcModel.province hasSuffix:@"特别行政区"]) {
        self.province = [rgcModel.province substringToIndex:2];
    }
    
    //市
    if ([rgcModel.city hasSuffix:@"市"]) {
        self.city = [rgcModel.city substringToIndex:rgcModel.city.length - 1];
    }
    
    //区
    self.district = rgcModel.district;
    
    //街道
    self.addressDetail = [NSString stringWithFormat:@"%@%@%@%@%@%@",NOTNIL(self.province),NOTNIL(self.city),NOTNIL(self.district),NOTNIL(rgcModel.town),NOTNIL(rgcModel.street),NOTNIL(rgcModel.streetNumber)];
    
    
//    if ([NBTookit findDistrictId:self.district].length == 0) {
//        [JKUserDefaults setObject:[NSString stringWithFormat:@"%@%@%@,%@+%@",self.province, self.city, self.district, [NBTookit findProvinceId:self.province], [NBTookit findCityId:self.city]] forKey:@"cacheCurrentAddress"];
//    } else {
//        [JKUserDefaults setObject:[NSString stringWithFormat:@"%@%@%@,%@+%@+%@",self.province, self.city, self.district, [NBTookit findProvinceId:self.province], [NBTookit findCityId:self.city], [NBTookit findDistrictId:self.district]] forKey:@"cacheCurrentAddress"];
//    }
    [JKUserDefaults synchronize];
    
    
    
    [self sendUserLocation];
}


#pragma mark -- 更新用户位置经纬度
- (void)sendUserLocation {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(self.userLocation.location.coordinate.latitude) forKey:@"lat"];
    [params setObject:@(self.userLocation.location.coordinate.longitude) forKey:@"lng"];
    [params setObject:NOTNIL(self.addressDetail) forKey:@"address"];
}

- (void) startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

- (void) handleCityCoordinate: (NSString*) cityName
                                andDistrictName: (NSString*) districtName {
    BMKDistrictSearchOption *districtOption = [[BMKDistrictSearchOption alloc] init];
    districtOption.city = cityName;
    districtOption.district = cityName;
    [self searchData:districtOption];
}

- (void) handleScopeCoordinate: (CLLocationCoordinate2D) point {
    BMKReverseGeoCodeSearchOption * option = [[BMKReverseGeoCodeSearchOption alloc] init];
    option.location = point;
    [self searchScopeData: option];
}

- (void) handleCityCoordinate:(NSString*) cityName
                   andAddress: (NSString*) address {
    BMKGeoCodeSearch * search = [[BMKGeoCodeSearch alloc] init];
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.address = address;
    geoCodeSearchOption.city = cityName;
    
    BOOL flag = [search geoCode: geoCodeSearchOption];
    if (flag) {
        NSLog(@"geo检索发送成功");
    }  else  {
        NSLog(@"geo检索发送失败");
    }
}


- (void)searchScopeData:(BMKReverseGeoCodeSearchOption *)option {
    //初始化BMKGeoCodeSearch实例
    BMKGeoCodeSearch *geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    //设置反地理编码检索的代理
    geoCodeSearch.delegate = self;
    //初始化请求参数类BMKReverseGeoCodeOption的实例
    BMKReverseGeoCodeSearchOption *reverseGeoCodeOption = [[BMKReverseGeoCodeSearchOption alloc] init];
    // 待解析的经纬度坐标（必选）
    reverseGeoCodeOption.location = option.location;
    //是否访问最新版行政区划数据（仅对中国数据生效）
    reverseGeoCodeOption.isLatestAdmin = option.isLatestAdmin;
    // 一次查询30条数据
    reverseGeoCodeOption.pageSize = 30;
    
    /**
     根据地理坐标获取地址信息：异步方法，返回结果在BMKGeoCodeSearchDelegate的
     onGetAddrResult里
     
     reverseGeoCodeOption 反geo检索信息类
     成功返回YES，否则返回NO
     */
    BOOL flag = [geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    if (flag) {
        NSLog(@"反地理编码检索成功");
    } else {
        NSLog(@"反地理编码检索失败");
    }
}




// 这个是根据城市、区的名字 找出来区域中心的坐标
- (void)searchData:(BMKDistrictSearchOption *)option {
    //初始化BMKDistrictSearch实例
    BMKDistrictSearch *districtSearch = [[BMKDistrictSearch alloc] init];
    //设置行政区域检索的代理
    districtSearch.delegate = self;
    //初始化请求参数类BMKDistrictSearchOption的实例
    BMKDistrictSearchOption *districtOption = [[BMKDistrictSearchOption alloc] init];
    //城市名，必选
    districtOption.city = option.city;
    //区县名字，可选
    districtOption.district = option.district;
    /**
     行政区域检索：异步方法，返回结果在BMKDistrictSearchDelegate的
     onGetDistrictResult里
     
     districtOption 公交线路检索信息类
     return 成功返回YES，否则返回NO
     */
    BOOL flag = [districtSearch districtSearch:districtOption];
    if (flag) {
        NSLog(@"行政区域检索发送成功");
    } else {
        NSLog(@"行政区域检索发送失败");
    }
}

- (void)onGetDistrictResult:(BMKDistrictSearch *)searcher result:(BMKDistrictResult *)result errorCode:(BMKSearchErrorCode)error {
    //BMKSearchErrorCode错误码，BMK_SEARCH_NO_ERROR：检索结果正常返回
    if (error == BMK_SEARCH_NO_ERROR) {
        NSString *message = [NSString stringWithFormat:@"行政区域编码：%ld\n行政区域名称：%@\n行政区域中心点：%f,%f", (long)result.code, result.name, result.center.latitude, result.center.longitude];
        NSLog(@"%@", message);
        
        if (self.transformSuccess) {
            self.transformSuccess( result.center.latitude, result.center.longitude );
        }
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSString *message = [NSString stringWithFormat:@"位置定位成功：%f,%f", result.location.latitude, result.location.longitude];
        NSLog(@"%@", message);
        if (self.addressSuccess) {
            self.addressSuccess( result.location.latitude, result.location.longitude );
        }
    }
    else {
        NSLog(@"检索失败");
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.scopTransformSuccess) {
            self.scopTransformSuccess( result.poiList );
        }
    }
}


@end
