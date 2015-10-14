//
//  BDMMovie.m
//
//  Created by hu  on 15/5/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDMMovie.h"


NSString *const kBDMMovieMovieTags = @"movie_tags";
NSString *const kBDMMovieMoviesWd = @"movies_wd";
NSString *const kBDMMovieMovieBigPicture = @"movie_big_picture";
NSString *const kBDMMovieMoviePicture = @"movie_picture";
NSString *const kBDMMovieMovieStarring = @"movie_starring";
NSString *const kBDMMovieMovieId = @"movie_id";
NSString *const kBDMMovieMovieScore = @"movie_score";
NSString *const kBDMMovieMovieNation = @"movie_nation";
NSString *const kBDMMovieIsImax = @"is_imax";
NSString *const kBDMMovieMovieDirector = @"movie_director";
NSString *const kBDMMovieMovieType = @"movie_type";
NSString *const kBDMMovieMovieName = @"movie_name";
NSString *const kBDMMovieMovieLength = @"movie_length";
NSString *const kBDMMovieIsNew = @"is_new";
NSString *const kBDMMovieMovieReleaseDate = @"movie_release_date";
NSString *const kBDMMovieMovieMessage = @"movie_message";


@interface BDMMovie ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDMMovie

@synthesize movieTags = _movieTags;
@synthesize moviesWd = _moviesWd;
@synthesize movieBigPicture = _movieBigPicture;
@synthesize moviePicture = _moviePicture;
@synthesize movieStarring = _movieStarring;
@synthesize movieId = _movieId;
@synthesize movieScore = _movieScore;
@synthesize movieNation = _movieNation;
@synthesize isImax = _isImax;
@synthesize movieDirector = _movieDirector;
@synthesize movieType = _movieType;
@synthesize movieName = _movieName;
@synthesize movieLength = _movieLength;
@synthesize isNew = _isNew;
@synthesize movieReleaseDate = _movieReleaseDate;
@synthesize movieMessage = _movieMessage;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.movieTags = [self objectOrNilForKey:kBDMMovieMovieTags fromDictionary:dict];
            self.moviesWd = [self objectOrNilForKey:kBDMMovieMoviesWd fromDictionary:dict];
            self.movieBigPicture = [self objectOrNilForKey:kBDMMovieMovieBigPicture fromDictionary:dict];
            self.moviePicture = [self objectOrNilForKey:kBDMMovieMoviePicture fromDictionary:dict];
            self.movieStarring = [self objectOrNilForKey:kBDMMovieMovieStarring fromDictionary:dict];
            self.movieId = [self objectOrNilForKey:kBDMMovieMovieId fromDictionary:dict];
            self.movieScore = [self objectOrNilForKey:kBDMMovieMovieScore fromDictionary:dict];
            self.movieNation = [self objectOrNilForKey:kBDMMovieMovieNation fromDictionary:dict];
            self.isImax = [[self objectOrNilForKey:kBDMMovieIsImax fromDictionary:dict] doubleValue];
            self.movieDirector = [self objectOrNilForKey:kBDMMovieMovieDirector fromDictionary:dict];
            self.movieType = [self objectOrNilForKey:kBDMMovieMovieType fromDictionary:dict];
            self.movieName = [self objectOrNilForKey:kBDMMovieMovieName fromDictionary:dict];
            self.movieLength = [self objectOrNilForKey:kBDMMovieMovieLength fromDictionary:dict];
            self.isNew = [self objectOrNilForKey:kBDMMovieIsNew fromDictionary:dict];
            self.movieReleaseDate = [self objectOrNilForKey:kBDMMovieMovieReleaseDate fromDictionary:dict];
            self.movieMessage = [self objectOrNilForKey:kBDMMovieMovieMessage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.movieTags forKey:kBDMMovieMovieTags];
    [mutableDict setValue:self.moviesWd forKey:kBDMMovieMoviesWd];
    [mutableDict setValue:self.movieBigPicture forKey:kBDMMovieMovieBigPicture];
    [mutableDict setValue:self.moviePicture forKey:kBDMMovieMoviePicture];
    [mutableDict setValue:self.movieStarring forKey:kBDMMovieMovieStarring];
    [mutableDict setValue:self.movieId forKey:kBDMMovieMovieId];
    [mutableDict setValue:self.movieScore forKey:kBDMMovieMovieScore];
    [mutableDict setValue:self.movieNation forKey:kBDMMovieMovieNation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isImax] forKey:kBDMMovieIsImax];
    [mutableDict setValue:self.movieDirector forKey:kBDMMovieMovieDirector];
    [mutableDict setValue:self.movieType forKey:kBDMMovieMovieType];
    [mutableDict setValue:self.movieName forKey:kBDMMovieMovieName];
    [mutableDict setValue:self.movieLength forKey:kBDMMovieMovieLength];
    [mutableDict setValue:self.isNew forKey:kBDMMovieIsNew];
    [mutableDict setValue:self.movieReleaseDate forKey:kBDMMovieMovieReleaseDate];
    [mutableDict setValue:self.movieMessage forKey:kBDMMovieMovieMessage];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.movieTags = [aDecoder decodeObjectForKey:kBDMMovieMovieTags];
    self.moviesWd = [aDecoder decodeObjectForKey:kBDMMovieMoviesWd];
    self.movieBigPicture = [aDecoder decodeObjectForKey:kBDMMovieMovieBigPicture];
    self.moviePicture = [aDecoder decodeObjectForKey:kBDMMovieMoviePicture];
    self.movieStarring = [aDecoder decodeObjectForKey:kBDMMovieMovieStarring];
    self.movieId = [aDecoder decodeObjectForKey:kBDMMovieMovieId];
    self.movieScore = [aDecoder decodeObjectForKey:kBDMMovieMovieScore];
    self.movieNation = [aDecoder decodeObjectForKey:kBDMMovieMovieNation];
    self.isImax = [aDecoder decodeDoubleForKey:kBDMMovieIsImax];
    self.movieDirector = [aDecoder decodeObjectForKey:kBDMMovieMovieDirector];
    self.movieType = [aDecoder decodeObjectForKey:kBDMMovieMovieType];
    self.movieName = [aDecoder decodeObjectForKey:kBDMMovieMovieName];
    self.movieLength = [aDecoder decodeObjectForKey:kBDMMovieMovieLength];
    self.isNew = [aDecoder decodeObjectForKey:kBDMMovieIsNew];
    self.movieReleaseDate = [aDecoder decodeObjectForKey:kBDMMovieMovieReleaseDate];
    self.movieMessage = [aDecoder decodeObjectForKey:kBDMMovieMovieMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_movieTags forKey:kBDMMovieMovieTags];
    [aCoder encodeObject:_moviesWd forKey:kBDMMovieMoviesWd];
    [aCoder encodeObject:_movieBigPicture forKey:kBDMMovieMovieBigPicture];
    [aCoder encodeObject:_moviePicture forKey:kBDMMovieMoviePicture];
    [aCoder encodeObject:_movieStarring forKey:kBDMMovieMovieStarring];
    [aCoder encodeObject:_movieId forKey:kBDMMovieMovieId];
    [aCoder encodeObject:_movieScore forKey:kBDMMovieMovieScore];
    [aCoder encodeObject:_movieNation forKey:kBDMMovieMovieNation];
    [aCoder encodeDouble:_isImax forKey:kBDMMovieIsImax];
    [aCoder encodeObject:_movieDirector forKey:kBDMMovieMovieDirector];
    [aCoder encodeObject:_movieType forKey:kBDMMovieMovieType];
    [aCoder encodeObject:_movieName forKey:kBDMMovieMovieName];
    [aCoder encodeObject:_movieLength forKey:kBDMMovieMovieLength];
    [aCoder encodeObject:_isNew forKey:kBDMMovieIsNew];
    [aCoder encodeObject:_movieReleaseDate forKey:kBDMMovieMovieReleaseDate];
    [aCoder encodeObject:_movieMessage forKey:kBDMMovieMovieMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDMMovie *copy = [[BDMMovie alloc] init];
    
    if (copy) {

        copy.movieTags = [self.movieTags copyWithZone:zone];
        copy.moviesWd = [self.moviesWd copyWithZone:zone];
        copy.movieBigPicture = [self.movieBigPicture copyWithZone:zone];
        copy.moviePicture = [self.moviePicture copyWithZone:zone];
        copy.movieStarring = [self.movieStarring copyWithZone:zone];
        copy.movieId = [self.movieId copyWithZone:zone];
        copy.movieScore = [self.movieScore copyWithZone:zone];
        copy.movieNation = [self.movieNation copyWithZone:zone];
        copy.isImax = self.isImax;
        copy.movieDirector = [self.movieDirector copyWithZone:zone];
        copy.movieType = [self.movieType copyWithZone:zone];
        copy.movieName = [self.movieName copyWithZone:zone];
        copy.movieLength = [self.movieLength copyWithZone:zone];
        copy.isNew = [self.isNew copyWithZone:zone];
        copy.movieReleaseDate = [self.movieReleaseDate copyWithZone:zone];
        copy.movieMessage = [self.movieMessage copyWithZone:zone];
    }
    
    return copy;
}


@end
