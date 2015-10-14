//
//  UtilsHelper.m
//  BDCarService
//
//  Created by hu on 15/5/13.
//
//

#import "FileHelper.h"
#import "SDImageCache.h"

@implementation FileHelper

+ (NSString *)getAppVersion
{
    NSString *appVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return appVersion;
}

+ (float)getSizeOfImage
{
    float size = [[SDImageCache sharedImageCache] getSize];
    
    return size/1024.0/1024.0;
}

+ (void)cleanCache
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] cleanDisk];
}

@end
