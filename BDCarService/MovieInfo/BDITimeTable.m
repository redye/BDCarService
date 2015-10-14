//
//  BDITimeTable.m
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDITimeTable.h"


NSString *const kBDITimeTableTime = @"time";
NSString *const kBDITimeTableDate = @"date";
NSString *const kBDITimeTableLan = @"lan";
NSString *const kBDITimeTableType = @"type";
NSString *const kBDITimeTablePrice = @"price";


@interface BDITimeTable ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDITimeTable

@synthesize time = _time;
@synthesize date = _date;
@synthesize lan = _lan;
@synthesize type = _type;
@synthesize price = _price;


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
            self.time = [self objectOrNilForKey:kBDITimeTableTime fromDictionary:dict];
            self.date = [self objectOrNilForKey:kBDITimeTableDate fromDictionary:dict];
            self.lan = [self objectOrNilForKey:kBDITimeTableLan fromDictionary:dict];
            self.type = [self objectOrNilForKey:kBDITimeTableType fromDictionary:dict];
            self.price = [[self objectOrNilForKey:kBDITimeTablePrice fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.time forKey:kBDITimeTableTime];
    [mutableDict setValue:self.date forKey:kBDITimeTableDate];
    [mutableDict setValue:self.lan forKey:kBDITimeTableLan];
    [mutableDict setValue:self.type forKey:kBDITimeTableType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kBDITimeTablePrice];

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

    self.time = [aDecoder decodeObjectForKey:kBDITimeTableTime];
    self.date = [aDecoder decodeObjectForKey:kBDITimeTableDate];
    self.lan = [aDecoder decodeObjectForKey:kBDITimeTableLan];
    self.type = [aDecoder decodeObjectForKey:kBDITimeTableType];
    self.price = [aDecoder decodeDoubleForKey:kBDITimeTablePrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_time forKey:kBDITimeTableTime];
    [aCoder encodeObject:_date forKey:kBDITimeTableDate];
    [aCoder encodeObject:_lan forKey:kBDITimeTableLan];
    [aCoder encodeObject:_type forKey:kBDITimeTableType];
    [aCoder encodeDouble:_price forKey:kBDITimeTablePrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDITimeTable *copy = [[BDITimeTable alloc] init];
    
    if (copy) {

        copy.time = [self.time copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.lan = [self.lan copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.price = self.price;
    }
    
    return copy;
}


@end
