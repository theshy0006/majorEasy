//
//  NBAreaModel.h
//  ChaZX
//
//  Created by zjk on 2018/7/24.
//  Copyright © 2018年 zjk. All rights reserved.
//

#import <Foundation/Foundation.h>
// 区对象
@interface NBDistrictModel : NSObject
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *districtId;
@property (nonatomic, copy) NSString *districtName;
@end

// 城市对象
@interface NBCityModel : NSObject
@property (nonatomic, copy) NSString *provinceId;
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *cityInitial;
@property (nonatomic, copy) NSString *cityPinYin;
@property (nonatomic, strong) NBDistrictModel *dModel;
@end
// 省份对象
@interface NBProvinceModel : NSObject
@property (nonatomic, copy) NSString *provinceId;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, strong) NBCityModel *cModel;
@end

@interface NBAreaModel : NSObject
@property (nonatomic, strong) NBProvinceModel *pModel;
@end
