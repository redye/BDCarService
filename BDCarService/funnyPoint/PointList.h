//
//  PointList.h
//
//  Created by hu  on 15/5/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location, AdditionalInformation;

@interface PointList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) AdditionalInformation *additionalInformation;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cityName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
