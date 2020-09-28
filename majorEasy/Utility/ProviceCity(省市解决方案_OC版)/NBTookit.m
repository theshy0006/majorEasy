//
//  NBTookit.m
//  ChaZX
//
//  Created by zjk on 2018/7/25.
//  Copyright © 2018年 zjk. All rights reserved.
//

#import "NBTookit.h"
#import "BGFMDB.h"
#import "NBAreaModel.h"

@implementation NBTookit

+ (BOOL)isChineseFirst:(NSString *)str {
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    BOOL b = [str getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isEmpty:(NSString *)str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

+ (BOOL)stringIsNull:(NSString *)str {
    return (str == nil || [str isKindOfClass:[NSNull class]]);
}

+ (NSString *)emptyStringToString:(NSString *)string {
    if (string == nil || [string isKindOfClass:[NSNull class]]) {
        return @"";
    }else{
        return string;
    }
}
+ (BOOL)numberIsNull:(NSNumber *)num {
    return (num == nil || [num isKindOfClass:[NSNull class]]);
}

+ (BOOL)arrayIsNull:(NSArray *)array {
    return (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0);
}

+ (BOOL)dictionaryIsNull:(NSDictionary *)dict {
    return (dict != nil && ![dict isKindOfClass:[NSNull class]] && dict.count != 0);
}

+ (NSString*)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTimeStr = [NSString stringWithFormat:@"%@ 23:59:59",[formatter stringFromDate:[NSDate date]]];
    return currentTimeStr;
}

+ (NSString*)getNextTime:(NSInteger)dayCount {
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:([components day] + dayCount)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    NSString *nextTimeStr = [NSString stringWithFormat:@"%@ 23:59:59",[dateday stringFromDate:beginningOfWeek]];
    return nextTimeStr;
}

#pragma mark -- 根据区ID获取区名
+ (NSString *)findDistrictName:(NSString *)districtId {
    NSString *like = districtId;
    NSString* where = [NSString stringWithFormat:@"where %@ like %@ order by %@",bg_sqlKey(@"districtId"),bg_sqlValue(like), bg_sqlKey(@"districtId")];
    NSArray* arr = [NBDistrictModel bg_find:District_TableName where:where];
    NBDistrictModel *model = [arr lastObject];
    return model.districtName;
}

#pragma mark -- 根据城市ID获取城市名
+ (NSString *)findCityName:(NSString *)cityId {
    NSString *like = cityId;
    NSString* where = [NSString stringWithFormat:@"where %@ like %@ order by %@",bg_sqlKey(@"cityId"),bg_sqlValue(like), bg_sqlKey(@"cityPinYin")];
    NSArray* arr = [NBCityModel bg_find:City_TableName where:where];
    NBCityModel *model = [arr lastObject];
    return model.cityName;
}

#pragma mark -- 根据省ID获取省名
+ (NSString *)findProvinceName:(NSString *)provinceId {
    NSString *like = provinceId;
    NSString* where = [NSString stringWithFormat:@"where %@ like %@ order by %@",bg_sqlKey(@"provinceId"),bg_sqlValue(like), bg_sqlKey(@"provinceId")];
    NSArray* arr = [NBProvinceModel bg_find:Province_TableName where:where];
    NBProvinceModel *model = [arr lastObject];
    return model.provinceName;
}

+ (NSString *)findDistrictId:(NSString *)districtName {
    NSString *like = districtName;
    NSString* where = [NSString stringWithFormat:@"where %@ like %@ order by %@",bg_sqlKey(@"districtName"),bg_sqlValue(like), bg_sqlKey(@"districtName")];
    NSArray* arr = [NBDistrictModel bg_find:District_TableName where:where];
    NBDistrictModel *model = [arr lastObject];
    return model.districtId ;
}

+ (NSString *)findCityId:(NSString *)cityName {
    NSString *like = cityName;
    NSString* where = [NSString stringWithFormat:@"where %@ like %@ order by %@",bg_sqlKey(@"cityName"),bg_sqlValue(like), bg_sqlKey(@"cityPinYin")];
    NSArray* arr = [NBCityModel bg_find:City_TableName where:where];
    NBCityModel *model = [arr lastObject];
    return model.cityId;
}

+ (NSString *)findProvinceId:(NSString *)provinceName {
    NSString *like = provinceName;
    NSString* where = [NSString stringWithFormat:@"where %@ like %@ order by %@",bg_sqlKey(@"provinceName"),bg_sqlValue(like), bg_sqlKey(@"provinceName")];
    NSArray* arr = [NBProvinceModel bg_find:Province_TableName where:where];
    NBProvinceModel *model = [arr lastObject];
    return model.provinceId;
}


@end
