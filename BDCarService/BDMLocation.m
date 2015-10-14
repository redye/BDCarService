//
//  BDMLocation.m
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDMLocation.h"


NSString *const kBDMLocationLng = @"lng";
NSString *const kBDMLocationLat = @"lat";


@interface BDMLocation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDMLocation

@synthesize lng = _lng;
@synthesize lat = _lat;


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
            self.lng = [[self objectOrNilForKey:kBDMLocationLng fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kBDMLocationLat fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kBDMLocationLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kBDMLocationLat];

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

    self.lng = [aDecoder decodeDoubleForKey:kBDMLocationLng];
    self.lat = [aDecoder decodeDoubleForKey:kBDMLocationLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lng forKey:kBDMLocationLng];
    [aCoder encodeDouble:_lat forKey:kBDMLocationLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDMLocation *copy = [[BDMLocation alloc] init];
    
    if (copy) {

        copy.lng = self.lng;
        copy.lat = self.lat;
    }
    
    return copy;
}


@end
