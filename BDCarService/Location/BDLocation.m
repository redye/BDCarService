//
//  BDLocation.m
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDLocation.h"
#import "BDResults.h"


NSString *const kBDLocationStatus = @"status";
NSString *const kBDLocationDistrict = @"district";
NSString *const kBDLocationStreet = @"street";
NSString *const kBDLocationCity = @"city";
NSString *const kBDLocationStreetNumber = @"street_number";
NSString *const kBDLocationResults = @"results";
NSString *const kBDLocationDescription = @"description";
NSString *const kBDLocationProvince = @"province";


@interface BDLocation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDLocation

@synthesize status = _status;
@synthesize district = _district;
@synthesize street = _street;
@synthesize city = _city;
@synthesize streetNumber = _streetNumber;
@synthesize results = _results;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize province = _province;


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
            self.status = [self objectOrNilForKey:kBDLocationStatus fromDictionary:dict];
            self.district = [self objectOrNilForKey:kBDLocationDistrict fromDictionary:dict];
            self.street = [self objectOrNilForKey:kBDLocationStreet fromDictionary:dict];
            self.city = [self objectOrNilForKey:kBDLocationCity fromDictionary:dict];
            self.streetNumber = [self objectOrNilForKey:kBDLocationStreetNumber fromDictionary:dict];
    NSObject *receivedBDResults = [dict objectForKey:kBDLocationResults];
    NSMutableArray *parsedBDResults = [NSMutableArray array];
    if ([receivedBDResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDResults addObject:[BDResults modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDResults isKindOfClass:[NSDictionary class]]) {
       [parsedBDResults addObject:[BDResults modelObjectWithDictionary:(NSDictionary *)receivedBDResults]];
    }

    self.results = [NSArray arrayWithArray:parsedBDResults];
            self.internalBaseClassDescription = [self objectOrNilForKey:kBDLocationDescription fromDictionary:dict];
            self.province = [self objectOrNilForKey:kBDLocationProvince fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBDLocationStatus];
    [mutableDict setValue:self.district forKey:kBDLocationDistrict];
    [mutableDict setValue:self.street forKey:kBDLocationStreet];
    [mutableDict setValue:self.city forKey:kBDLocationCity];
    [mutableDict setValue:self.streetNumber forKey:kBDLocationStreetNumber];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kBDLocationResults];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kBDLocationDescription];
    [mutableDict setValue:self.province forKey:kBDLocationProvince];

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

    self.status = [aDecoder decodeObjectForKey:kBDLocationStatus];
    self.district = [aDecoder decodeObjectForKey:kBDLocationDistrict];
    self.street = [aDecoder decodeObjectForKey:kBDLocationStreet];
    self.city = [aDecoder decodeObjectForKey:kBDLocationCity];
    self.streetNumber = [aDecoder decodeObjectForKey:kBDLocationStreetNumber];
    self.results = [aDecoder decodeObjectForKey:kBDLocationResults];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kBDLocationDescription];
    self.province = [aDecoder decodeObjectForKey:kBDLocationProvince];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBDLocationStatus];
    [aCoder encodeObject:_district forKey:kBDLocationDistrict];
    [aCoder encodeObject:_street forKey:kBDLocationStreet];
    [aCoder encodeObject:_city forKey:kBDLocationCity];
    [aCoder encodeObject:_streetNumber forKey:kBDLocationStreetNumber];
    [aCoder encodeObject:_results forKey:kBDLocationResults];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kBDLocationDescription];
    [aCoder encodeObject:_province forKey:kBDLocationProvince];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDLocation *copy = [[BDLocation alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.district = [self.district copyWithZone:zone];
        copy.street = [self.street copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.streetNumber = [self.streetNumber copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
    }
    
    return copy;
}


@end
