//
//  BDWeather.m
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDWWeather.h"
#import "BDWResults.h"


NSString *const kBDWeatherStatus = @"status";
NSString *const kBDWeatherResults = @"results";
NSString *const kBDWeatherError = @"error";
NSString *const kBDWeatherDate = @"date";


@interface BDWWeather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDWWeather

@synthesize status = _status;
@synthesize results = _results;
@synthesize error = _error;
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
            self.status = [self objectOrNilForKey:kBDWeatherStatus fromDictionary:dict];
    NSObject *receivedBDResults = [dict objectForKey:kBDWeatherResults];
    NSMutableArray *parsedBDResults = [NSMutableArray array];
    if ([receivedBDResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDResults addObject:[BDWResults modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDResults isKindOfClass:[NSDictionary class]]) {
       [parsedBDResults addObject:[BDWResults modelObjectWithDictionary:(NSDictionary *)receivedBDResults]];
    }

    self.results = [NSArray arrayWithArray:parsedBDResults];
            self.error = [[self objectOrNilForKey:kBDWeatherError fromDictionary:dict] doubleValue];
            self.date = [self objectOrNilForKey:kBDWeatherDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBDWeatherStatus];
    NSMutableArray *tempArrayForResults = [NSMutableArray array];
    for (NSObject *subArrayObject in self.results) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResults addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kBDWeatherResults];
    [mutableDict setValue:[NSNumber numberWithDouble:self.error] forKey:kBDWeatherError];
    [mutableDict setValue:self.date forKey:kBDWeatherDate];

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

    self.status = [aDecoder decodeObjectForKey:kBDWeatherStatus];
    self.results = [aDecoder decodeObjectForKey:kBDWeatherResults];
    self.error = [aDecoder decodeDoubleForKey:kBDWeatherError];
    self.date = [aDecoder decodeObjectForKey:kBDWeatherDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBDWeatherStatus];
    [aCoder encodeObject:_results forKey:kBDWeatherResults];
    [aCoder encodeDouble:_error forKey:kBDWeatherError];
    [aCoder encodeObject:_date forKey:kBDWeatherDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDWWeather *copy = [[BDWWeather alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
        copy.error = self.error;
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
