//
//  BDALandMark.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDALandMark.h"
#import "BDALocation.h"


NSString *const kBDALandMarkName = @"name";
NSString *const kBDALandMarkLocation = @"location";
NSString *const kBDALandMarkType = @"type";


@interface BDALandMark ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDALandMark

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
            self.name = [self objectOrNilForKey:kBDALandMarkName fromDictionary:dict];
            self.location = [BDALocation modelObjectWithDictionary:[dict objectForKey:kBDALandMarkLocation]];
            self.type = [[self objectOrNilForKey:kBDALandMarkType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kBDALandMarkName];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDALandMarkLocation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kBDALandMarkType];

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

    self.name = [aDecoder decodeObjectForKey:kBDALandMarkName];
    self.location = [aDecoder decodeObjectForKey:kBDALandMarkLocation];
    self.type = [aDecoder decodeDoubleForKey:kBDALandMarkType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kBDALandMarkName];
    [aCoder encodeObject:_location forKey:kBDALandMarkLocation];
    [aCoder encodeDouble:_type forKey:kBDALandMarkType];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDALandMark *copy = [[BDALandMark alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.type = self.type;
    }
    
    return copy;
}


@end
