//
//  BDWeatherData.h
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BDWWeatherData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *wind;
@property (nonatomic, strong) NSString *nightPictureUrl;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *dayPictureUrl;
@property (nonatomic, strong) NSString *date;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
