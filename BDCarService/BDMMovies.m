//
//  BDMMovies.m
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDMMovies.h"
#import "BDMResult.h"


NSString *const kBDMMoviesStatus = @"status";
NSString *const kBDMMoviesResult = @"result";
NSString *const kBDMMoviesError = @"error";
NSString *const kBDMMoviesDate = @"date";


@interface BDMMovies ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDMMovies

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
            self.status = [self objectOrNilForKey:kBDMMoviesStatus fromDictionary:dict];
            self.result = [BDMResult modelObjectWithDictionary:[dict objectForKey:kBDMMoviesResult]];
            self.error = [[self objectOrNilForKey:kBDMMoviesError fromDictionary:dict] doubleValue];
            self.date = [self objectOrNilForKey:kBDMMoviesDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBDMMoviesStatus];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kBDMMoviesResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.error] forKey:kBDMMoviesError];
    [mutableDict setValue:self.date forKey:kBDMMoviesDate];

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

    self.status = [aDecoder decodeObjectForKey:kBDMMoviesStatus];
    self.result = [aDecoder decodeObjectForKey:kBDMMoviesResult];
    self.error = [aDecoder decodeDoubleForKey:kBDMMoviesError];
    self.date = [aDecoder decodeObjectForKey:kBDMMoviesDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBDMMoviesStatus];
    [aCoder encodeObject:_result forKey:kBDMMoviesResult];
    [aCoder encodeDouble:_error forKey:kBDMMoviesError];
    [aCoder encodeObject:_date forKey:kBDMMoviesDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDMMovies *copy = [[BDMMovies alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.error = self.error;
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
