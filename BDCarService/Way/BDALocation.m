//
//  BDALocation.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDALocation.h"


NSString *const kBDALocationLng = @"lng";
NSString *const kBDALocationLat = @"lat";


@interface BDALocation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDALocation

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
            self.lng = [[self objectOrNilForKey:kBDALocationLng fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kBDALocationLat fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kBDALocationLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kBDALocationLat];

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

    self.lng = [aDecoder decodeDoubleForKey:kBDALocationLng];
    self.lat = [aDecoder decodeDoubleForKey:kBDALocationLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lng forKey:kBDALocationLng];
    [aCoder encodeDouble:_lat forKey:kBDALocationLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDALocation *copy = [[BDALocation alloc] init];
    
    if (copy) {

        copy.lng = self.lng;
        copy.lat = self.lat;
    }
    
    return copy;
}


@end
