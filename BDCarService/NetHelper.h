//
//  NetHelper.h
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import <Foundation/Foundation.h>

@interface NetHelper : NSObject

//将经纬度转换为汉字表示的地名
+ (void)nameFromLng:(double)lng
                lat:(double)lat
            success:(void(^)(NSString *name))success
            failure:(void(^)(NSError *error))faliure;
//将地名转换为经纬度表示



@end
