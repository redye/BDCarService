//
//  BDWayViewController.m
//  BDCarService
//
//  Created by hu on 15/5/16.
//
//

#import "BDWayViewController.h"
#import "BDAWayModels.h"
#import "BDWayCell.h"
#import "BDWayHeader.h"
#import "NetHelper.h"

#define kORGIN 10000
#define kDESTINATION 10001

NSString *const kWayCellID = @"wayCellID";
NSString *const kWayHeadID = @"wayHeadID";

@interface BDWayViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *orginField;
@property (nonatomic, strong) UITextField *destinationField;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString    *orgin;
@property (nonatomic, strong) NSString    *destination;
@property (nonatomic, strong) BDAWay      *way;
@property (nonatomic, strong) NSArray     *sectionArray;
@property (nonatomic, strong) NSArray     *tempArray;

@end

@implementation BDWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionArray = @[@"主要路段", @"停车场", @"交通灯", @"摄像头", @"路标", @"路口"];
}

- (void)addSubViews
{
    [super addSubViews];
    self.iconImageView.image = [UIImage imageNamed:@"new"];
    
    self.keywordField.hidden = YES;
    self.drawView.hidden = YES;
    
    _orginField = [[UITextField alloc] initWithFrame:CGRectMake(120, 74, kBOUNDS.size.width-120-10, kFieldHeight)];
    _orginField.placeholder = @"请输入起点";
    _orginField.borderStyle = UITextBorderStyleRoundedRect;
    [_orginField addTarget:self action:@selector(startSelect:) forControlEvents:UIControlEventEditingDidEndOnExit];
    _orginField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _orginField.delegate = self;
    [self.view addSubview:_orginField];
    
    _destinationField = [[UITextField alloc] initWithFrame:CGRectMake(120, 74+10+kFieldHeight, kBOUNDS.size.width-120-10, kFieldHeight)];
    _destinationField.placeholder = @"请输入终点";
    _destinationField.borderStyle = UITextBorderStyleRoundedRect;
    [_destinationField addTarget:self action:@selector(startSelect:) forControlEvents:UIControlEventEditingDidEndOnExit];
    _destinationField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _destinationField.delegate = self;
    [self.view addSubview:_destinationField];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopPadding, kBOUNDS.size.width, kBOUNDS.size.height-kTopPadding) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[BDWayCell class] forCellReuseIdentifier:kWayCellID];
    [_tableView registerClass:[BDWayHeader class] forHeaderFooterViewReuseIdentifier:kWayHeadID];
    _tableView.hidden = YES;
    _tableView.rowHeight = 80;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.dataArray objectAtIndex:section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDWayCell *cell = (BDWayCell *)[tableView dequeueReusableCellWithIdentifier:kWayCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            BDAMainRoad *mainRoad = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = mainRoad.name;
            [NetHelper nameFromLng:mainRoad.location.lng lat:mainRoad.location.lat success:^(NSString *name) {
                cell.locaionLabel.text = name;
            } failure:^(NSError *error) {
                NSLog(@"转化错误");
            }];
            cell.webView.hidden = YES;
            cell.addressLabel.hidden = YES;
            cell.speedLabel.hidden = YES;
        }
            break;
        case 1:
        {
            BDACarPark *carPark = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = carPark.name;
            [NetHelper nameFromLng:carPark.location.lng lat:carPark.location.lat success:^(NSString *name) {
                cell.locaionLabel.text = name;
            } failure:^(NSError *error) {
            }];
            cell.addressLabel.text = carPark.address;
            cell.webView.hidden = YES;
            cell.addressLabel.hidden = NO;
            cell.speedLabel.hidden = YES;
        }
            break;
        case 2:
        {
            BDATrafficLight *light = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = light.name;
            [NetHelper nameFromLng:light.location.lng lat:light.location.lat success:^(NSString *name) {
                cell.locaionLabel.text = name;
            } failure:^(NSError *error) {
                
            }];
            cell.webView.hidden = YES;
            cell.addressLabel.hidden = YES;
            cell.speedLabel.hidden = YES;
        }
            break;
        case 3:
        {
            BDACamera *camera = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = camera.name;
            cell.speedLabel.text = [NSString stringWithFormat:@"%.0f", camera.speed];
            [NetHelper nameFromLng:camera.location.lng lat:camera.location.lat success:^(NSString *name) {
                cell.locaionLabel.text = name;
            } failure:^(NSError *error) {
                
            }];
            cell.webView.hidden = YES;
            cell.addressLabel.hidden = YES;
            cell.speedLabel.hidden = NO;
        }
            break;
        case 4:
        {
            BDALandMark *mark = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = mark.name;
            [NetHelper nameFromLng:mark.location.lng lat:mark.location.lat success:^(NSString *name) {
                cell.locaionLabel.text = name;
            } failure:^(NSError *error) {
                
            }];
            cell.webView.hidden = YES;
            cell.addressLabel.hidden = YES;
            cell.speedLabel.hidden = YES;
        }
            break;

        case 5:
        {
            BDAEntrance *entrace = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = entrace.name;
            [NetHelper nameFromLng:entrace.location.lng lat:entrace.location.lat success:^(NSString *name) {
                cell.locaionLabel.text = name;
            } failure:^(NSError *error) {
            }];
            [cell.webView loadHTMLString:entrace.direction baseURL:nil];
            cell.webView.hidden = NO;
            cell.addressLabel.hidden = YES;
            cell.speedLabel.hidden = YES;
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDWayHeader *header = (BDWayHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kWayHeadID];
    
//    if (!header)
//    {
//        header = [[BDWayHeader alloc] initWithReuseIdentifier:kWayHeadID];
//    }
//    [header setSelectedBlock:^(BOOL isSelected){
//        if (isSelected)
//        {
//            [self.dataArray replaceObjectAtIndex:section withObject:[NSArray array]];
//        }
//        else
//        {
//            [self.dataArray replaceObjectAtIndex:section withObject:self.tempArray[section]];
//        }
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
//    }];

    header.textLabel.text = _sectionArray[section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _orginField)
    {
        self.orgin = textField.text;
        return;
    }
    
    self.destination = textField.text;
}

- (void)startSelect:(UITextField *)input
{
    if (input == _orginField)
    {
        self.orgin = input.text;
    }
    else
    {
        self.destination = input.text;
    }
    [self loadRequest];

}

- (BOOL)confirmInput
{
    BOOL isOK = NO;
    
    if (self.orgin.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入起点" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        alertView.tag = kORGIN;
        [alertView show];
        return isOK;
        
    }
    
    if (self.destination.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入终点" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        alertView.tag = kDESTINATION;
        [alertView show];
        return isOK;
    }
    
    isOK = YES;
    return isOK;
}

- (void)loadRequest
{
    if (![self confirmInput])
    {
        return;
    }
    
    NSDictionary *parameters = @{@"origin":self.orgin, @"destination":self.destination, @"output":@"json", @"mcode":kMCode, @"ak":kAK};
    [self.manager GET:[NSString stringWithFormat:@"%@%@", kBaseAddress, kWay] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", [(NSDictionary *)responseObject description]);
        self.way = [BDAWay modelObjectWithDictionary:responseObject];
        NSArray *roadArray = self.way.results.mainRoad;
        NSArray *parkArray = self.way.results.carPark;
        NSArray *lightArray = self.way.results.trafficLight;
        NSArray *cameraArray = self.way.results.camera;
        NSArray *markArray = self.way.results.landMark;
        NSArray *entraceArray = self.way.results.entrance;
        self.dataArray = [NSMutableArray arrayWithObjects:roadArray, parkArray, lightArray, cameraArray, markArray, entraceArray, nil];
        self.tempArray = [NSArray arrayWithArray:self.dataArray];
        [_tableView reloadData];
        _tableView.hidden = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求途径路段信息出错 %ld, %@", error.code, error.localizedDescription);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
