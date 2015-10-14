//
//  UtilsHelper.h
//  BDCarService
//
//  Created by hu on 15/5/16.
//
//

#import <Foundation/Foundation.h>

@interface UtilsHelper : NSObject

//创建正在进行的风火轮
+ (void)showActivityIndicatorOnView:(UIView *)view;
//移除
+ (void)removeActivityIndicatorFromView:(UIView *)view;
//显示请求失败的信息
+ (void)showFailedInfo:(NSString *)info onView:(UIView *)view;
+ (void)removeFailedInfoOnView:(UIView *)view;

@end
