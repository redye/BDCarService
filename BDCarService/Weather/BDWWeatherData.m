//
//  BDWeatherData.m
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDWWeatherData.h"


NSString *const kBDWeatherDataTemperature = @"temperature";
NSString *const kBDWeatherDataWind = @"wind";
NSString *const kBDWeatherDataNightPictureUrl = @"nightPictureUrl";
NSString *const kBDWeatherDataWeather = @"weather";
NSString *const kBDWeatherDataDayPictureUrl = @"dayPictureUrl";
NSString *const kBDWeatherDataDate = @"date";


@interface BDWWeatherData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDWWeatherData

@synthesize temperature = _temperature;
@synthesize wind = _wind;
@synthesize nightPictureUrl = _nightPictureUrl;
@synthesize weather = _weather;
@synthesize dayPictureUrl = _dayPictureUrl;
@synthesize date = _date;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.temperature = [self objectOrNilForKey:kBDWeatherDataTemperature fromDictionary:dict];
            self.wind = [self objectOrNilForKey:kBDWeatherDataWind fromDictionary:dict];
            self.nightPictureUrl = [self objectOrNilForKey:kBDWeatherDataNightPictureUrl fromDictionary:dict];
            self.weather = [self objectOrNilForKey:kBDWeatherDataWeather fromDictionary:dict];
            self.dayPictureUrl = [self objectOrNilForKey:kBDWeatherDataDayPictureUrl fromDictionary:dict];
            self.date = [self objectOrNilForKey:kBDWeatherDataDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.temperature forKey:kBDWeatherDataTemperature];
    [mutableDict setValue:self.wind forKey:kBDWeatherDataWind];
    [mutableDict setValue:self.nightPictureUrl forKey:kBDWeatherDataNightPictureUrl];
    [mutableDict setValue:self.weather forKey:kBDWeatherDataWeather];
    [mutableDict setValue:self.dayPictureUrl forKey:kBDWeatherDataDayPictureUrl];
    [mutableDict setValue:self.date forKey:kBDWeatherDataDate];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.temperature = [aDecoder decodeObjectForKey:kBDWeatherDataTemperature];
    self.wind = [aDecoder decodeObjectForKey:kBDWeatherDataWind];
    self.nightPictureUrl = [aDecoder decodeObjectForKey:kBDWeatherDataNightPictureUrl];
    self.weather = [aDecoder decodeObjectForKey:kBDWeatherDataWeather];
    self.dayPictureUrl = [aDecoder decodeObjectForKey:kBDWeatherDataDayPictureUrl];
    self.date = [aDecoder decodeObjectForKey:kBDWeatherDataDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_temperature forKey:kBDWeatherDataTemperature];
    [aCoder encodeObject:_wind forKey:kBDWeatherDataWind];
    [aCoder encodeObject:_nightPictureUrl forKey:kBDWeatherDataNightPictureUrl];
    [aCoder encodeObject:_weather forKey:kBDWeatherDataWeather];
    [aCoder encodeObject:_dayPictureUrl forKey:kBDWeatherDataDayPictureUrl];
    [aCoder encodeObject:_date forKey:kBDWeatherDataDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDWWeatherData *copy = [[BDWWeatherData alloc] init];
    
    if (copy) {

        copy.temperature = [self.temperature copyWithZone:zone];
        copy.wind = [self.wind copyWithZone:zone];
        copy.nightPictureUrl = [self.nightPictureUrl copyWithZone:zone];
        copy.weather = [self.weather copyWithZone:zone];
        copy.dayPictureUrl = [self.dayPictureUrl copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
