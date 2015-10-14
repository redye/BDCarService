//
//  BDALocation.h
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BDALocation : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double lat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
