//
//  BDMResult.h
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDMLocation;

@interface BDMResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *movie;
@property (nonatomic, strong) NSString *cityname;
@property (nonatomic, strong) BDMLocation *location;
@property (nonatomic, assign) double cityid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
