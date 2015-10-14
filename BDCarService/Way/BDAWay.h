//
//  BDAWay.h
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDAResults;

@interface BDAWay : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double error;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) BDAResults *results;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
