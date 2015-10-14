//
//  AppDelegate.m
//  BDCarService
//
//  Created by hu on 15/4/28.
//
//

#import "AppDelegate.h"

#import "DDMenuController.h"
#import "BDRootViewController.h"
#import "BDLeftViewController.h"
#import "BDPlaceManager.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"

#import "BMapKit.h"

@interface AppDelegate ()
{
    BMKMapManager   *_mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    DDMenuController *menuController = [[DDMenuController alloc] init];
    BDRootViewController *rootController = [[BDRootViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
    BDLeftViewController *leftController = [[BDLeftViewController alloc] init];
    menuController.rootViewController = navigationController;
    menuController.leftViewController = leftController;
    self.window.rootViewController = menuController;
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:kAK  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"manager start YES!");
    }
    
    //分享
    [ShareSDK registerApp:kAPP_KEY];
    //添加新浪微博应用 注册网址
    [ShareSDK connectSinaWeiboWithAppKey:kSINA_KEY
                               appSecret:kSINA_SECRET
                               redirectUri:kSINA_URL
                               weiboSDKCls:[WeiboSDK class]];
    [ShareSDK connectSinaWeiboWithAppKey:kSINA_KEY
                               appSecret:kSINA_SECRET
                             redirectUri:kSINA_URL];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
