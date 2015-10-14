//
//  BDIndex.m
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDWIndex.h"


NSString *const kBDIndexTitle = @"title";
NSString *const kBDIndexTipt = @"tipt";
NSString *const kBDIndexZs = @"zs";
NSString *const kBDIndexDes = @"des";


@interface BDWIndex ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDWIndex

@synthesize title = _title;
@synthesize tipt = _tipt;
@synthesize zs = _zs;
@synthesize des = _des;


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
            self.title = [self objectOrNilForKey:kBDIndexTitle fromDictionary:dict];
            self.tipt = [self objectOrNilForKey:kBDIndexTipt fromDictionary:dict];
            self.zs = [self objectOrNilForKey:kBDIndexZs fromDictionary:dict];
            self.des = [self objectOrNilForKey:kBDIndexDes fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kBDIndexTitle];
    [mutableDict setValue:self.tipt forKey:kBDIndexTipt];
    [mutableDict setValue:self.zs forKey:kBDIndexZs];
    [mutableDict setValue:self.des forKey:kBDIndexDes];

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

    self.title = [aDecoder decodeObjectForKey:kBDIndexTitle];
    self.tipt = [aDecoder decodeObjectForKey:kBDIndexTipt];
    self.zs = [aDecoder decodeObjectForKey:kBDIndexZs];
    self.des = [aDecoder decodeObjectForKey:kBDIndexDes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kBDIndexTitle];
    [aCoder encodeObject:_tipt forKey:kBDIndexTipt];
    [aCoder encodeObject:_zs forKey:kBDIndexZs];
    [aCoder encodeObject:_des forKey:kBDIndexDes];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDWIndex *copy = [[BDWIndex alloc] init];
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.tipt = [self.tipt copyWithZone:zone];
        copy.zs = [self.zs copyWithZone:zone];
        copy.des = [self.des copyWithZone:zone];
    }
    
    return copy;
}


@end
