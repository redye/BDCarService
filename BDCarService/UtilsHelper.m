//
//  UtilsHelper.m
//  BDCarService
//
//  Created by hu on 15/5/16.
//
//

#import "UtilsHelper.h"
#import "NSString+Additions.h"
#define kBOX_TAG 10001
#define kBOX_INFO 10002

@implementation UtilsHelper

+ (void)showActivityIndicatorOnView:(UIView *)view;
{
    
    UIView *boxView = [[UIView alloc] init];
    boxView.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMaxY(view.frame)/3);
    boxView.bounds = CGRectMake(0, 0, 80, 80);
    boxView.layer.cornerRadius = 5;
    boxView.layer.masksToBounds = YES;
    boxView.tag = kBOX_TAG;
    boxView.backgroundColor = kRGBA(0, 0, 0, 0.6);
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = CGPointMake(CGRectGetMidX(boxView.bounds), CGRectGetMidY(boxView.bounds));
    activityView.bounds = CGRectMake(0, 0, 40, 40);
    [boxView addSubview:activityView];
    [activityView startAnimating];
    [view addSubview:boxView];
}

+ (void)removeActivityIndicatorFromView:(UIView *)view
{
    UIView *boxView = [view viewWithTag:kBOX_TAG];
    [boxView removeFromSuperview];
    boxView =nil;
}

+ (void)showFailedInfo:(NSString *)info onView:(UIView *)view
{
    
    UIView *infoView = [[UIView alloc] init];
    infoView.center = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMaxY(view.frame)/3);
    CGSize size = [info sizeOfString];
    infoView.bounds = CGRectMake(0, 0, size.width+40, size.height+40);
    infoView.layer.cornerRadius = 5;
    infoView.layer.masksToBounds = YES;
    infoView.tag = kBOX_INFO;
    infoView.backgroundColor = kRGBA(0, 0, 0, 0.6);
    [view addSubview:infoView];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, size.width, size.height)];
    infoLabel.text = info;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:infoLabel];
}

+ (void)removeFailedInfoOnView:(UIView *)view
{
    UIView *infoView = [view viewWithTag:kBOX_INFO];
    [infoView removeFromSuperview];
    infoView = nil;
}

@end
