//
//  BDAWay.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDAWay.h"
#import "BDAResults.h"


NSString *const kBDAWayError = @"error";
NSString *const kBDAWayStatus = @"status";
NSString *const kBDAWayResults = @"results";


@interface BDAWay ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDAWay

@synthesize error = _error;
@synthesize status = _status;
@synthesize results = _results;


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
            self.error = [[self objectOrNilForKey:kBDAWayError fromDictionary:dict] doubleValue];
            self.status = [self objectOrNilForKey:kBDAWayStatus fromDictionary:dict];
            self.results = [BDAResults modelObjectWithDictionary:[dict objectForKey:kBDAWayResults]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.error] forKey:kBDAWayError];
    [mutableDict setValue:self.status forKey:kBDAWayStatus];
    [mutableDict setValue:[self.results dictionaryRepresentation] forKey:kBDAWayResults];

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

    self.error = [aDecoder decodeDoubleForKey:kBDAWayError];
    self.status = [aDecoder decodeObjectForKey:kBDAWayStatus];
    self.results = [aDecoder decodeObjectForKey:kBDAWayResults];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_error forKey:kBDAWayError];
    [aCoder encodeObject:_status forKey:kBDAWayStatus];
    [aCoder encodeObject:_results forKey:kBDAWayResults];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDAWay *copy = [[BDAWay alloc] init];
    
    if (copy) {

        copy.error = self.error;
        copy.status = [self.status copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
    }
    
    return copy;
}


@end
