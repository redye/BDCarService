//
//  BDIInfo.m
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDIInfo.h"
#import "BDIResult.h"


NSString *const kBDIInfoStatus = @"status";
NSString *const kBDIInfoResult = @"result";
NSString *const kBDIInfoError = @"error";
NSString *const kBDIInfoDate = @"date";


@interface BDIInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDIInfo

@synthesize status = _status;
@synthesize result = _result;
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
            self.status = [self objectOrNilForKey:kBDIInfoStatus fromDictionary:dict];
    NSObject *receivedBDIResult = [dict objectForKey:kBDIInfoResult];
    NSMutableArray *parsedBDIResult = [NSMutableArray array];
    if ([receivedBDIResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDIResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDIResult addObject:[BDIResult modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDIResult isKindOfClass:[NSDictionary class]]) {
       [parsedBDIResult addObject:[BDIResult modelObjectWithDictionary:(NSDictionary *)receivedBDIResult]];
    }

    self.result = [NSArray arrayWithArray:parsedBDIResult];
            self.error = [[self objectOrNilForKey:kBDIInfoError fromDictionary:dict] doubleValue];
            self.date = [self objectOrNilForKey:kBDIInfoDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBDIInfoStatus];
    NSMutableArray *tempArrayForResult = [NSMutableArray array];
    for (NSObject *subArrayObject in self.result) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResult addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResult addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kBDIInfoResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.error] forKey:kBDIInfoError];
    [mutableDict setValue:self.date forKey:kBDIInfoDate];

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

    self.status = [aDecoder decodeObjectForKey:kBDIInfoStatus];
    self.result = [aDecoder decodeObjectForKey:kBDIInfoResult];
    self.error = [aDecoder decodeDoubleForKey:kBDIInfoError];
    self.date = [aDecoder decodeObjectForKey:kBDIInfoDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBDIInfoStatus];
    [aCoder encodeObject:_result forKey:kBDIInfoResult];
    [aCoder encodeDouble:_error forKey:kBDIInfoError];
    [aCoder encodeObject:_date forKey:kBDIInfoDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDIInfo *copy = [[BDIInfo alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.error = self.error;
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
