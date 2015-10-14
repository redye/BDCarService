//
//  BDItemSuperViewController.h
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import <UIKit/UIKit.h>
#import "BoxDropDownList.h"
#import "BDPlaceManager.h"
#import "AFNetworking.h"
#import "SVPullToRefresh.h"
#import "UtilsHelper.h"

#define kFieldHeight 33

typedef void(^DetailsWillShowedBlock)(UIViewController *);

@interface BDItemSuperViewController : UIViewController

@property (nonatomic, strong) UIImageView          *iconImageView;
@property (nonatomic, strong) UITextField          *keywordField;
@property (nonatomic, strong) BoxDropDownList      *drawView;
@property (nonatomic, strong) NSMutableDictionary  *parameters;
@property (nonatomic, strong) NSString             *keyword;
@property (nonatomic, strong) NSString             *cityName;
@property (nonatomic, assign) NSInteger             page;
@property (nonatomic, strong) NSMutableArray       *dataArray;
@property (nonatomic, copy) DetailsWillShowedBlock  detailsBlock;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;


- (void)addSubViews;
- (void)loadRequest;
- (void)startSelect:(UITextField *)input;

@end
