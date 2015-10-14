//
//  BDResults.m
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDWResults.h"
#import "BDWWeatherData.h"
#import "BDWIndex.h"


NSString *const kBDResultsWeatherData = @"weather_data";
NSString *const kBDResultsCurrentCity = @"currentCity";
NSString *const kBDResultsPm25 = @"pm25";
NSString *const kBDResultsIndex = @"index";


@interface BDWResults ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDWResults

@synthesize weatherData = _weatherData;
@synthesize currentCity = _currentCity;
@synthesize pm25 = _pm25;
@synthesize index = _index;


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
    NSObject *receivedBDWeatherData = [dict objectForKey:kBDResultsWeatherData];
    NSMutableArray *parsedBDWeatherData = [NSMutableArray array];
    if ([receivedBDWeatherData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDWeatherData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDWeatherData addObject:[BDWWeatherData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDWeatherData isKindOfClass:[NSDictionary class]]) {
       [parsedBDWeatherData addObject:[BDWWeatherData modelObjectWithDictionary:(NSDictionary *)receivedBDWeatherData]];
    }

    self.weatherData = [NSArray arrayWithArray:parsedBDWeatherData];
            self.currentCity = [self objectOrNilForKey:kBDResultsCurrentCity fromDictionary:dict];
            self.pm25 = [self objectOrNilForKey:kBDResultsPm25 fromDictionary:dict];
    NSObject *receivedBDIndex = [dict objectForKey:kBDResultsIndex];
    NSMutableArray *parsedBDIndex = [NSMutableArray array];
    if ([receivedBDIndex isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDIndex) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDIndex addObject:[BDWIndex modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDIndex isKindOfClass:[NSDictionary class]]) {
       [parsedBDIndex addObject:[BDWIndex modelObjectWithDictionary:(NSDictionary *)receivedBDIndex]];
    }

    self.index = [NSArray arrayWithArray:parsedBDIndex];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForWeatherData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weatherData) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeatherData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeatherData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeatherData] forKey:kBDResultsWeatherData];
    [mutableDict setValue:self.currentCity forKey:kBDResultsCurrentCity];
    [mutableDict setValue:self.pm25 forKey:kBDResultsPm25];
    NSMutableArray *tempArrayForIndex = [NSMutableArray array];
    for (NSObject *subArrayObject in self.index) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForIndex addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForIndex addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForIndex] forKey:kBDResultsIndex];

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

    self.weatherData = [aDecoder decodeObjectForKey:kBDResultsWeatherData];
    self.currentCity = [aDecoder decodeObjectForKey:kBDResultsCurrentCity];
    self.pm25 = [aDecoder decodeObjectForKey:kBDResultsPm25];
    self.index = [aDecoder decodeObjectForKey:kBDResultsIndex];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_weatherData forKey:kBDResultsWeatherData];
    [aCoder encodeObject:_currentCity forKey:kBDResultsCurrentCity];
    [aCoder encodeObject:_pm25 forKey:kBDResultsPm25];
    [aCoder encodeObject:_index forKey:kBDResultsIndex];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDWResults *copy = [[BDWResults alloc] init];
    
    if (copy) {

        copy.weatherData = [self.weatherData copyWithZone:zone];
        copy.currentCity = [self.currentCity copyWithZone:zone];
        copy.pm25 = [self.pm25 copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
    }
    
    return copy;
}


@end
