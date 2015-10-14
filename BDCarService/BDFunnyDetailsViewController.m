//
//  BDFunnyDetailsViewController.m
//  BDCarService
//
//  Created by hu on 15/5/12.
//
//

#import "BDFunnyDetailsViewController.h"
#import "UILabel+Additions.h"
#import "NSString+Additions.h"

#define kTop 74
#define kLabelHeight 30
#define kSpace 10

@interface BDFunnyDetailsViewController ()

@property (nonatomic, strong) UILabel    *nameLabel;
@property (nonatomic, strong) UILabel    *tagLabel;
@property (nonatomic, strong) UILabel    *typeLabel;
@property (nonatomic, strong) UILabel    *addressLabel;
@property (nonatomic, strong) UILabel    *distLabel;
@property (nonatomic, strong) UILabel    *teleLabel;

@end

@implementation BDFunnyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.title = self.pointList.name;
    
    [self addSubViews];
}

- (void)addSubViews
{
    NSInteger count = 0;
    int i = 0;
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+(kLabelHeight+kSpace)*count, kBOUNDS.size.width, kLabelHeight) text:self.pointList.name font:17];
    _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:_nameLabel];
    _nameLabel.backgroundColor = [UIColor whiteColor];
    count ++;
    
    CGFloat tagWidth = [self.pointList.additionalInformation.tag sizeOfString].width;
    if (self.pointList.additionalInformation.tag.length > 0)
    {
        _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+(kLabelHeight+kSpace)*count, tagWidth+10, kLabelHeight) text:self.pointList.additionalInformation.tag font:15];
        _tagLabel.backgroundColor = kRGB(135, 206, 250);
        _tagLabel.textColor = [UIColor whiteColor];
        _tagLabel.layer.cornerRadius = 5;
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tagLabel];
        i++;
    }
    
    NSString *text = [self.pointList.type subString];
    if (self.pointList.type.length > 0)
    {
        CGFloat typeWidth = [text sizeOfString].width;
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+tagWidth+20*i+kSpace, kTop+(kLabelHeight+kSpace)*count, typeWidth+10, kLabelHeight) text:text font:15];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.backgroundColor = kRGB(255, 228, 181);
        _typeLabel.layer.cornerRadius = 5;
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_typeLabel];
    }

    count ++;
    
    UILabel *disLab = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+(kLabelHeight+kSpace)*count, 70, kLabelHeight) text:@"行政区" font:17];
    [self.view addSubview:disLab];
    _distLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+70, kTop+(kLabelHeight+kSpace)*count, kBOUNDS.size.width-100, kLabelHeight) text:self.pointList.district font:17];
    [self.view addSubview:_distLabel];
    count ++;
    
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+(kLabelHeight+kSpace)*count, 100, kLabelHeight*3) text:@"地址" font:17];
    [self.view addSubview:addressLab];
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+70, kTop+(kLabelHeight+kSpace)*count, kBOUNDS.size.width-100, kLabelHeight*3) text:self.pointList.address font:17];
    _addressLabel.numberOfLines = 0;
    [self.view addSubview:_addressLabel];
    count += 3;
    
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(20, kTop+(kLabelHeight+kSpace)*count, 100, kLabelHeight) text:@"电话" font:17];
    [self.view addSubview:phoneLab];
    _teleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+70, kTop+(kLabelHeight+kSpace)*count, kBOUNDS.size.width-100, kLabelHeight) text:self.pointList.additionalInformation.telephone font:17];
    _teleLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_teleLabel];
    count ++;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
