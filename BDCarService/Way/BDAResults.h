//
//  BDAResults.h
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BDAResults : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *carPark;
@property (nonatomic, strong) NSArray *mainRoad;
@property (nonatomic, strong) NSArray *trafficLight;
@property (nonatomic, strong) NSArray *camera;
@property (nonatomic, strong) NSArray *landMark;
@property (nonatomic, strong) NSArray *entrance;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
