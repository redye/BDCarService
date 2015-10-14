//
//  BDMResult.m
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDMResult.h"
#import "BDMMovie.h"
#import "BDMLocation.h"


NSString *const kBDMResultMovie = @"movie";
NSString *const kBDMResultCityname = @"cityname";
NSString *const kBDMResultLocation = @"location";
NSString *const kBDMResultCityid = @"cityid";


@interface BDMResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDMResult

@synthesize movie = _movie;
@synthesize cityname = _cityname;
@synthesize location = _location;
@synthesize cityid = _cityid;


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
    NSObject *receivedBDMMovie = [dict objectForKey:kBDMResultMovie];
    NSMutableArray *parsedBDMMovie = [NSMutableArray array];
    if ([receivedBDMMovie isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDMMovie) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDMMovie addObject:[BDMMovie modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDMMovie isKindOfClass:[NSDictionary class]]) {
       [parsedBDMMovie addObject:[BDMMovie modelObjectWithDictionary:(NSDictionary *)receivedBDMMovie]];
    }

    self.movie = [NSArray arrayWithArray:parsedBDMMovie];
            self.cityname = [self objectOrNilForKey:kBDMResultCityname fromDictionary:dict];
            self.location = [BDMLocation modelObjectWithDictionary:[dict objectForKey:kBDMResultLocation]];
            self.cityid = [[self objectOrNilForKey:kBDMResultCityid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForMovie = [NSMutableArray array];
    for (NSObject *subArrayObject in self.movie) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMovie addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMovie addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMovie] forKey:kBDMResultMovie];
    [mutableDict setValue:self.cityname forKey:kBDMResultCityname];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDMResultLocation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityid] forKey:kBDMResultCityid];

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

    self.movie = [aDecoder decodeObjectForKey:kBDMResultMovie];
    self.cityname = [aDecoder decodeObjectForKey:kBDMResultCityname];
    self.location = [aDecoder decodeObjectForKey:kBDMResultLocation];
    self.cityid = [aDecoder decodeDoubleForKey:kBDMResultCityid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_movie forKey:kBDMResultMovie];
    [aCoder encodeObject:_cityname forKey:kBDMResultCityname];
    [aCoder encodeObject:_location forKey:kBDMResultLocation];
    [aCoder encodeDouble:_cityid forKey:kBDMResultCityid];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDMResult *copy = [[BDMResult alloc] init];
    
    if (copy) {

        copy.movie = [self.movie copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.cityid = self.cityid;
    }
    
    return copy;
}


@end
