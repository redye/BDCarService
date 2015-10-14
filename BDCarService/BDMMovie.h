//
//  BDMMovie.h
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BDMMovie : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *movieTags;
@property (nonatomic, strong) NSString *moviesWd;
@property (nonatomic, strong) NSString *movieBigPicture;
@property (nonatomic, strong) NSString *moviePicture;
@property (nonatomic, strong) NSString *movieStarring;
@property (nonatomic, strong) NSString *movieId;
@property (nonatomic, strong) NSString *movieScore;
@property (nonatomic, strong) NSString *movieNation;
@property (nonatomic, assign) double isImax;
@property (nonatomic, strong) NSString *movieDirector;
@property (nonatomic, strong) NSString *movieType;
@property (nonatomic, strong) NSString *movieName;
@property (nonatomic, strong) NSString *movieLength;
@property (nonatomic, strong) NSString *isNew;
@property (nonatomic, strong) NSString *movieReleaseDate;
@property (nonatomic, strong) NSString *movieMessage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
