//
//  BDResults.h
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BDWResults : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *weatherData;
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) NSString *pm25;
@property (nonatomic, strong) NSArray *index;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
