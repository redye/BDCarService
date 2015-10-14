//
//  BDIResult.h
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDILocation;

@interface BDIResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSArray *timeTable;
@property (nonatomic, strong) BDILocation *location;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
