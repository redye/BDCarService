//
//  BDAMainRoad.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDAMainRoad.h"
#import "BDALocation.h"


NSString *const kBDAMainRoadName = @"name";
NSString *const kBDAMainRoadLocation = @"location";
NSString *const kBDAMainRoadType = @"type";


@interface BDAMainRoad ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDAMainRoad

@synthesize name = _name;
@synthesize location = _location;
@synthesize type = _type;


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
            self.name = [self objectOrNilForKey:kBDAMainRoadName fromDictionary:dict];
            self.location = [BDALocation modelObjectWithDictionary:[dict objectForKey:kBDAMainRoadLocation]];
            self.type = [[self objectOrNilForKey:kBDAMainRoadType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kBDAMainRoadName];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDAMainRoadLocation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kBDAMainRoadType];

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

    self.name = [aDecoder decodeObjectForKey:kBDAMainRoadName];
    self.location = [aDecoder decodeObjectForKey:kBDAMainRoadLocation];
    self.type = [aDecoder decodeDoubleForKey:kBDAMainRoadType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kBDAMainRoadName];
    [aCoder encodeObject:_location forKey:kBDAMainRoadLocation];
    [aCoder encodeDouble:_type forKey:kBDAMainRoadType];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDAMainRoad *copy = [[BDAMainRoad alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.type = self.type;
    }
    
    return copy;
}


@end
