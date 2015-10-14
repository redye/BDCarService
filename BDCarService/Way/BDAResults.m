//
//  BDAResults.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDAResults.h"
#import "BDACarPark.h"
#import "BDAMainRoad.h"
#import "BDATrafficLight.h"
#import "BDACamera.h"
#import "BDALandMark.h"
#import "BDAEntrance.h"


NSString *const kBDAResultsCarPark = @"carPark";
NSString *const kBDAResultsMainRoad = @"mainRoad";
NSString *const kBDAResultsTrafficLight = @"trafficLight";
NSString *const kBDAResultsCamera = @"camera";
NSString *const kBDAResultsLandMark = @"landMark";
NSString *const kBDAResultsEntrance = @"entrance";


@interface BDAResults ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDAResults

@synthesize carPark = _carPark;
@synthesize mainRoad = _mainRoad;
@synthesize trafficLight = _trafficLight;
@synthesize camera = _camera;
@synthesize landMark = _landMark;
@synthesize entrance = _entrance;


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
    NSObject *receivedBDACarPark = [dict objectForKey:kBDAResultsCarPark];
    NSMutableArray *parsedBDACarPark = [NSMutableArray array];
    if ([receivedBDACarPark isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDACarPark) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDACarPark addObject:[BDACarPark modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDACarPark isKindOfClass:[NSDictionary class]]) {
       [parsedBDACarPark addObject:[BDACarPark modelObjectWithDictionary:(NSDictionary *)receivedBDACarPark]];
    }

    self.carPark = [NSArray arrayWithArray:parsedBDACarPark];
    NSObject *receivedBDAMainRoad = [dict objectForKey:kBDAResultsMainRoad];
    NSMutableArray *parsedBDAMainRoad = [NSMutableArray array];
    if ([receivedBDAMainRoad isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDAMainRoad) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDAMainRoad addObject:[BDAMainRoad modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDAMainRoad isKindOfClass:[NSDictionary class]]) {
       [parsedBDAMainRoad addObject:[BDAMainRoad modelObjectWithDictionary:(NSDictionary *)receivedBDAMainRoad]];
    }

    self.mainRoad = [NSArray arrayWithArray:parsedBDAMainRoad];
    NSObject *receivedBDATrafficLight = [dict objectForKey:kBDAResultsTrafficLight];
    NSMutableArray *parsedBDATrafficLight = [NSMutableArray array];
    if ([receivedBDATrafficLight isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDATrafficLight) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDATrafficLight addObject:[BDATrafficLight modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDATrafficLight isKindOfClass:[NSDictionary class]]) {
       [parsedBDATrafficLight addObject:[BDATrafficLight modelObjectWithDictionary:(NSDictionary *)receivedBDATrafficLight]];
    }

    self.trafficLight = [NSArray arrayWithArray:parsedBDATrafficLight];
    NSObject *receivedBDACamera = [dict objectForKey:kBDAResultsCamera];
    NSMutableArray *parsedBDACamera = [NSMutableArray array];
    if ([receivedBDACamera isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDACamera) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDACamera addObject:[BDACamera modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDACamera isKindOfClass:[NSDictionary class]]) {
       [parsedBDACamera addObject:[BDACamera modelObjectWithDictionary:(NSDictionary *)receivedBDACamera]];
    }

    self.camera = [NSArray arrayWithArray:parsedBDACamera];
    NSObject *receivedBDALandMark = [dict objectForKey:kBDAResultsLandMark];
    NSMutableArray *parsedBDALandMark = [NSMutableArray array];
    if ([receivedBDALandMark isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDALandMark) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDALandMark addObject:[BDALandMark modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDALandMark isKindOfClass:[NSDictionary class]]) {
       [parsedBDALandMark addObject:[BDALandMark modelObjectWithDictionary:(NSDictionary *)receivedBDALandMark]];
    }

    self.landMark = [NSArray arrayWithArray:parsedBDALandMark];
    NSObject *receivedBDAEntrance = [dict objectForKey:kBDAResultsEntrance];
    NSMutableArray *parsedBDAEntrance = [NSMutableArray array];
    if ([receivedBDAEntrance isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBDAEntrance) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBDAEntrance addObject:[BDAEntrance modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBDAEntrance isKindOfClass:[NSDictionary class]]) {
       [parsedBDAEntrance addObject:[BDAEntrance modelObjectWithDictionary:(NSDictionary *)receivedBDAEntrance]];
    }

    self.entrance = [NSArray arrayWithArray:parsedBDAEntrance];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCarPark = [NSMutableArray array];
    for (NSObject *subArrayObject in self.carPark) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCarPark addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCarPark addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCarPark] forKey:kBDAResultsCarPark];
    NSMutableArray *tempArrayForMainRoad = [NSMutableArray array];
    for (NSObject *subArrayObject in self.mainRoad) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMainRoad addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMainRoad addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMainRoad] forKey:kBDAResultsMainRoad];
    NSMutableArray *tempArrayForTrafficLight = [NSMutableArray array];
    for (NSObject *subArrayObject in self.trafficLight) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTrafficLight addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTrafficLight addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTrafficLight] forKey:kBDAResultsTrafficLight];
    NSMutableArray *tempArrayForCamera = [NSMutableArray array];
    for (NSObject *subArrayObject in self.camera) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCamera addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCamera addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCamera] forKey:kBDAResultsCamera];
    NSMutableArray *tempArrayForLandMark = [NSMutableArray array];
    for (NSObject *subArrayObject in self.landMark) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLandMark addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLandMark addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLandMark] forKey:kBDAResultsLandMark];
    NSMutableArray *tempArrayForEntrance = [NSMutableArray array];
    for (NSObject *subArrayObject in self.entrance) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEntrance addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEntrance addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEntrance] forKey:kBDAResultsEntrance];

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

    self.carPark = [aDecoder decodeObjectForKey:kBDAResultsCarPark];
    self.mainRoad = [aDecoder decodeObjectForKey:kBDAResultsMainRoad];
    self.trafficLight = [aDecoder decodeObjectForKey:kBDAResultsTrafficLight];
    self.camera = [aDecoder decodeObjectForKey:kBDAResultsCamera];
    self.landMark = [aDecoder decodeObjectForKey:kBDAResultsLandMark];
    self.entrance = [aDecoder decodeObjectForKey:kBDAResultsEntrance];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_carPark forKey:kBDAResultsCarPark];
    [aCoder encodeObject:_mainRoad forKey:kBDAResultsMainRoad];
    [aCoder encodeObject:_trafficLight forKey:kBDAResultsTrafficLight];
    [aCoder encodeObject:_camera forKey:kBDAResultsCamera];
    [aCoder encodeObject:_landMark forKey:kBDAResultsLandMark];
    [aCoder encodeObject:_entrance forKey:kBDAResultsEntrance];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDAResults *copy = [[BDAResults alloc] init];
    
    if (copy) {

        copy.carPark = [self.carPark copyWithZone:zone];
        copy.mainRoad = [self.mainRoad copyWithZone:zone];
        copy.trafficLight = [self.trafficLight copyWithZone:zone];
        copy.camera = [self.camera copyWithZone:zone];
        copy.landMark = [self.landMark copyWithZone:zone];
        copy.entrance = [self.entrance copyWithZone:zone];
    }
    
    return copy;
}


@end
