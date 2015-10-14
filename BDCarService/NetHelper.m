//
//  NetHelper.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "NetHelper.h"
#import "AFNetworking.h"
#import "BDLocationModels.h"

@implementation NetHelper

+ (void)nameFromLng:(double)lng
                lat:(double)lat
            success:(void(^)(NSString *name))success
            failure:(void(^)(NSError *error))faliure
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/reverseGeocoding?location=%f,%f&mcode=%@&output=json&coord_type=gcj02&ak=%@", lng, lat, kMCode, kAK];
    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseAddress, kReCode];
//    NSString *location = [NSString stringWithFormat:@"%f,%f", lng, lat];
//    NSDictionary *parameters = @{@"location":location, @"coord_type":@"gcj02", @"output":@"json", @"mcode":kMCode, @"ak":kAK};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", [(NSDictionary *)responseObject description]);
        BDLocation *location = [BDLocation modelObjectWithDictionary:responseObject];
        success(location.internalBaseClassDescription);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"经纬度转换出错 %ld, %@", error.code, error.localizedDescription);
        faliure(error);
    }];
}

@end
