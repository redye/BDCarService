//
//  BDIResult.m
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDIResult.h"
#import "BDITimeTable.h"
#import "BDILocation.h"


NSString *const kBDIResultRating = @"rating";
NSString *const kBDIResultUid = @"uid";
NSString *const kBDIResultTimeTable = @"time_table";
NSString *const kBDIResultLocation = @"location";
NSString *const kBDIResultAddress = @"address";
NSString *const kBDIResultTelephone = @"telephone";
NSString *const kBDIResultName = @"name";


@interface BDIResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDIResult

@synthesize rating = _rating;
@synthesize uid = _uid;
@synthesize timeTable = _timeTable;
@synthesize location = _location;
@synthesize address = _address;
@synthesize telephone = _telephone;
@synthesize name = _name;


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
            self.rating = [self objectOrNilForKey:kBDIResultRating fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kBDIResultUid fromDictionary:dict];
    NSObject *receivedBDITimeTable = [dict objectForKey:kBDIResultTimeTable];
    NSMutableArray *parsedBDITimeTable = [NSMutableArray array];
    if ([receivedBDITimeTable isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDITimeTable) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDITimeTable addObject:[BDITimeTable modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDITimeTable isKindOfClass:[NSDictionary class]]) {
       [parsedBDITimeTable addObject:[BDITimeTable modelObjectWithDictionary:(NSDictionary *)receivedBDITimeTable]];
    }

    self.timeTable = [NSArray arrayWithArray:parsedBDITimeTable];
            self.location = [BDILocation modelObjectWithDictionary:[dict objectForKey:kBDIResultLocation]];
            self.address = [self objectOrNilForKey:kBDIResultAddress fromDictionary:dict];
            self.telephone = [self objectOrNilForKey:kBDIResultTelephone fromDictionary:dict];
            self.name = [self objectOrNilForKey:kBDIResultName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rating forKey:kBDIResultRating];
    [mutableDict setValue:self.uid forKey:kBDIResultUid];
    NSMutableArray *tempArrayForTimeTable = [NSMutableArray array];
    for (NSObject *subArrayObject in self.timeTable) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTimeTable addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTimeTable addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTimeTable] forKey:kBDIResultTimeTable];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDIResultLocation];
    [mutableDict setValue:self.address forKey:kBDIResultAddress];
    [mutableDict setValue:self.telephone forKey:kBDIResultTelephone];
    [mutableDict setValue:self.name forKey:kBDIResultName];

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

    self.rating = [aDecoder decodeObjectForKey:kBDIResultRating];
    self.uid = [aDecoder decodeObjectForKey:kBDIResultUid];
    self.timeTable = [aDecoder decodeObjectForKey:kBDIResultTimeTable];
    self.location = [aDecoder decodeObjectForKey:kBDIResultLocation];
    self.address = [aDecoder decodeObjectForKey:kBDIResultAddress];
    self.telephone = [aDecoder decodeObjectForKey:kBDIResultTelephone];
    self.name = [aDecoder decodeObjectForKey:kBDIResultName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rating forKey:kBDIResultRating];
    [aCoder encodeObject:_uid forKey:kBDIResultUid];
    [aCoder encodeObject:_timeTable forKey:kBDIResultTimeTable];
    [aCoder encodeObject:_location forKey:kBDIResultLocation];
    [aCoder encodeObject:_address forKey:kBDIResultAddress];
    [aCoder encodeObject:_telephone forKey:kBDIResultTelephone];
    [aCoder encodeObject:_name forKey:kBDIResultName];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDIResult *copy = [[BDIResult alloc] init];
    
    if (copy) {

        copy.rating = [self.rating copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.timeTable = [self.timeTable copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.telephone = [self.telephone copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
