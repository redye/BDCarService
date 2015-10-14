//
//  BDACarPark.h
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDALocation;

@interface BDACarPark : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) BDALocation *location;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
