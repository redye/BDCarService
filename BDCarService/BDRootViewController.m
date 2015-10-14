//
//  BDRootViewController.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "BDRootViewController.h"
#import "BMapKit.h"
#import "AppDelegate.h"
#import "DDMenuController.h"
#import "BDSetViewController.h"

#import "BDFunnyDetailsViewController.h"
#import "BDWeatherViewController.h"
#import "BDAroundViewController.h"
#import "BDTrafficViewController.h"
#import "BDDistanceViewController.h"
#import "BDTravelViewController.h"
#import "BDDriveViewController.h"
#import "BDCodeViewController.h"
#import "BDWayViewController.h"
#import "BDMovieViewController.h"
#import "BDVisitViewController.h"

#import "BDFunnyPointViewController.h"
#import "AFNetworking.h"
#import "BDLocation.h"
#import "BDPlaceManager.h"

#import <ShareSDK/ShareSDK.h>

//分享按钮的边长
#define kSHARE_WIDTH 40

@interface BDRootViewController () <BMKLocationServiceDelegate>
{
    BMKLocationService *_locService;
}

@property (nonatomic, strong) BMKUserLocation *location;
@property (nonatomic, strong) NSArray         *viewControllers;
@property (nonatomic, assign) NSInteger        lastType;

@end

@implementation BDRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"兴趣点搜索";
    
    //菜单按钮
//    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"caidan"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    //设置按钮
//    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shezhi"] style:UIBarButtonItemStylePlain target:self action:@selector(showSetting)];
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithTitle:@"关于" style:UIBarButtonItemStylePlain target:self action:@selector(showSetting)];
    self.navigationItem.rightBarButtonItem = setItem;
    
    [self toLocation];
    [self addGestureAndShowRootViewController];
    [self addObserverOfNotificationToShowRoot];
    
    [self addSubViews];
    
    //分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(CGRectGetMaxX(kBOUNDS)-kSHARE_WIDTH, CGRectGetMidY(kBOUNDS)-kSHARE_WIDTH/2.0, kSHARE_WIDTH, kSHARE_WIDTH);
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareButton.backgroundColor = kRGB(76, 175, 245);
    shareButton.layer.cornerRadius = 5;
    shareButton.layer.masksToBounds = YES;
    [shareButton addTarget:self action:@selector(shareSomething:) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    [window addSubview:shareButton];
}

#pragma mark - 分享
- (void)shareSomething:(UIButton *)sender
{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:nil]
                                                title:@"Share"
                                                  url:@"http://www.baidu.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义标题栏相关委托
    /*
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"Share"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:self
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
     */

    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}

#pragma mark - 显示菜单
- (void)showMenu
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    DDMenuController *ddMenu = (DDMenuController *)delegate.window.rootViewController;
    [ddMenu showLeftController:YES];
}

#pragma mark - 显示设置页
- (void)showSetting
{
    BDSetViewController *setController = [[BDSetViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:setController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _locService.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    _locService.delegate = nil;
}

#pragma mark - 添加子视图
- (void)addSubViews
{
    BDFunnyPointViewController *funnyController = [[BDFunnyPointViewController alloc] init];
//    BDAroundViewController *aroundController = [[BDAroundViewController alloc] init];
//    BDTrafficViewController *trafficController = [[BDTrafficViewController alloc] init];
//    BDDistanceViewController *distanceController = [[BDDistanceViewController alloc] init];
//    BDDriveViewController *driveController = [[BDDriveViewController alloc] init];
//    BDCodeViewController *codeController = [[BDCodeViewController alloc] init];
    BDWayViewController *wayController = [[BDWayViewController alloc] init];
    BDWeatherViewController *weatherController = [[BDWeatherViewController alloc] init];
//    BDTravelViewController *travelController = [[BDTravelViewController alloc] init];
//    BDVisitViewController *visitController = [[BDVisitViewController alloc] init];
    BDMovieViewController *movieController = [[BDMovieViewController alloc] init];
//    self.viewControllers = @[funnyController, aroundController, trafficController, distanceController, driveController, codeController, wayController, weatherController, travelController, visitController, movieController];
        self.viewControllers = @[funnyController,  wayController, weatherController, movieController];
    //初始化block快
    __weak BDRootViewController *safeSelf = self;
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setDetailsBlock:^(UIViewController *viewController){
            [safeSelf.navigationController pushViewController:viewController animated:YES];
        }];
    }];
    
    [self addChildViewController:funnyController];
    [self.view addSubview:funnyController.view];
    self.lastType = 0;
}

#pragma mark - 添加向左滑动以及点击的手势显示跟视图
- (void)addGestureAndShowRootViewController
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showRootViewController)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
}

- (void)showRootViewController
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    DDMenuController *ddmenu = (DDMenuController *)delegate.window.rootViewController;
    [ddmenu showRootController:YES];
}

#pragma mark - 定位
- (void)toLocation
{
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}


#pragma mark - 定位的相关代理方法
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.location  = userLocation;
    NSLog(@"%@", userLocation);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/reverseGeocoding?location=%f,%f&mcode=%@&output=json&coord_type=gcj02&ak=%@", userLocation.location.coordinate.longitude, userLocation.location.coordinate.latitude, kMCode, kAK];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        BDLocation *location = [BDLocation modelObjectWithDictionary:responseObject];
        [BDPlaceManager sharedManager].placeName = location.city;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"反编译位置失败 %ld, %@", error.code, error.localizedDescription);
    }];
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"定位失败" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
//    [alertView show];
}

#pragma mark - 添加通知监听及方法
- (void)addObserverOfNotificationToShowRoot
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMenuItem:) name:kBDMenuDidChangeNotification object:nil];
}

- (void)changeMenuItem:(NSNotification *)notify
{
    self.title = [notify.userInfo objectForKey:kMenuItem];
    NSInteger type = [[notify.userInfo objectForKey:kMenuType] integerValue];
    //移除上一个显示的视图，显示被选择的查询对象
    UIViewController *lastController = [self.viewControllers objectAtIndex:_lastType];
    [lastController.view removeFromSuperview];
    [lastController removeFromParentViewController];
    
    UIViewController *viewControlle =[self.viewControllers objectAtIndex:type];
    [self addChildViewController:viewControlle];
    [self.view addSubview:viewControlle.view];
    
    self.lastType = type;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBDMenuDidChangeNotification object:nil];
}

@end
