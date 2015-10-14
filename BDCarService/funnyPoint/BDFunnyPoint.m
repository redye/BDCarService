//
//  BDFunnyPoint.m
//
//  Created by hu  on 15/5/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDFunnyPoint.h"
#import "PointList.h"


NSString *const kBDFunnyPointStatus = @"status";
NSString *const kBDFunnyPointPointList = @"pointList";
NSString *const kBDFunnyPointCount = @"count";
NSString *const kBDFunnyPointTotal = @"total";


@interface BDFunnyPoint ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDFunnyPoint

@synthesize status = _status;
@synthesize pointList = _pointList;
@synthesize count = _count;
@synthesize total = _total;


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
            self.status = [self objectOrNilForKey:kBDFunnyPointStatus fromDictionary:dict];
    NSObject *receivedPointList = [dict objectForKey:kBDFunnyPointPointList];
    NSMutableArray *parsedPointList = [NSMutableArray array];
    if ([receivedPointList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPointList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPointList addObject:[PointList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPointList isKindOfClass:[NSDictionary class]]) {
       [parsedPointList addObject:[PointList modelObjectWithDictionary:(NSDictionary *)receivedPointList]];
    }

    self.pointList = [NSArray arrayWithArray:parsedPointList];
            self.count = [[self objectOrNilForKey:kBDFunnyPointCount fromDictionary:dict] doubleValue];
            self.total = [[self objectOrNilForKey:kBDFunnyPointTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBDFunnyPointStatus];
    NSMutableArray *tempArrayForPointList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.pointList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPointList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPointList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPointList] forKey:kBDFunnyPointPointList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kBDFunnyPointCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kBDFunnyPointTotal];

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

    self.status = [aDecoder decodeObjectForKey:kBDFunnyPointStatus];
    self.pointList = [aDecoder decodeObjectForKey:kBDFunnyPointPointList];
    self.count = [aDecoder decodeDoubleForKey:kBDFunnyPointCount];
    self.total = [aDecoder decodeDoubleForKey:kBDFunnyPointTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBDFunnyPointStatus];
    [aCoder encodeObject:_pointList forKey:kBDFunnyPointPointList];
    [aCoder encodeDouble:_count forKey:kBDFunnyPointCount];
    [aCoder encodeDouble:_total forKey:kBDFunnyPointTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDFunnyPoint *copy = [[BDFunnyPoint alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.pointList = [self.pointList copyWithZone:zone];
        copy.count = self.count;
        copy.total = self.total;
    }
    
    return copy;
}


@end
