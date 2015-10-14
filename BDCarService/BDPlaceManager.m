//
//  BDPlaceManager.m
//  BDCarService
//
//  Created by hu on 15/5/13.
//
//

#import "BDPlaceManager.h"

static BDPlaceManager *singletonInstance = nil;

@implementation BDPlaceManager
@synthesize placeArray = _placeArray;

+ (BDPlaceManager *)sharedManager
{
    @synchronized(self)
    {
        if (singletonInstance == nil)
        {
            singletonInstance = [[super allocWithZone:NULL] init];
        }
    }
    
    return singletonInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _placeName = @"淮南市";
    }
    
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return singletonInstance;
}

+ (instancetype)copyWithZone:(struct _NSZone *)zone
{
    return singletonInstance;
}

- (void)insertToPlaceArrayWithObject:(NSString *)cityName
{
    if (!self.placeArray)
    {
        self.placeArray = [NSMutableArray array];
    }
    //判断是否已经存在
    if ([self.placeArray containsObject:cityName])
    {
        return;
    }

    if (self.placeArray.count >= 10)
    {
        [self.placeArray removeLastObject];
    }
    [self.placeArray insertObject:cityName atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[BDPlaceManager sharedManager].placeArray forKey:kHistory];
}


@end
