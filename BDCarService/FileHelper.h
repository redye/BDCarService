//
//  UtilsHelper.h
//  BDCarService
//
//  Created by hu on 15/5/13.
//
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

//获取 APP 的版本号
+ (NSString *)getAppVersion;

//计算缓存图片的大小
+ (float)getSizeOfImage;

//清楚图片缓存
+ (void)cleanCache;

@end
