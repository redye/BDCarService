//
//  BDACamera.h
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDALocation;

@interface BDACamera : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double speed;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) BDALocation *location;
@property (nonatomic, assign) double type;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
