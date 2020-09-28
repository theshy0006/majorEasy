//
//  NBTookit.h
//  ChaZX
//
//  Created by zjk on 2018/7/25.
//  Copyright © 2018年 zjk. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Province_TableName @"ProvinceDB"
#define City_TableName @"CityDB"
#define District_TableName @"DistrictDB"
#define Contact_TableName @"ContactDB"

@interface NBTookit : NSObject

+ (BOOL)isChineseFirst:(NSString *)str;
+ (BOOL)isEmpty:(NSString *)str;

+ (BOOL)stringIsNull:(NSString *)str;
+ (BOOL)numberIsNull:(NSNumber *)num;
+ (BOOL)arrayIsNull:(NSArray *)array;
+ (BOOL)dictionaryIsNull:(NSDictionary *)dict;

+ (NSString *)emptyStringToString:(NSString *)string;
+ (NSString *)getCurrentTime;
+ (NSString *)getNextTime:(NSInteger)dayCount;

+ (NSString *)findDistrictName:(NSString *)districtId;
+ (NSString *)findCityName:(NSString *)cityId;
+ (NSString *)findProvinceName:(NSString *)provinceId;

+ (NSString *)findDistrictId:(NSString *)districtName;
+ (NSString *)findCityId:(NSString *)cityName;
+ (NSString *)findProvinceId:(NSString *)provinceName;

@end
