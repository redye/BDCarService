//
//  BDPlaceManager.h
//  BDCarService
//
//  Created by hu on 15/5/13.
//
//

#import <Foundation/Foundation.h>

@interface BDPlaceManager : NSObject

@property (nonatomic, strong) NSMutableArray *placeArray;
@property (nonatomic, strong) NSString       *placeName;

+ (BDPlaceManager *)sharedManager;
- (void)insertToPlaceArrayWithObject:(NSString *)cityName;

@end
