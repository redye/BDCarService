//
//  BDWeatherViewController.m
//  BDCarService
//
//  Created by hu on 15/5/16.
//
//

#import "BDWeatherViewController.h"
#import "BDWeatherModels.h"
#import "BDWeatherCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Additions.h"

NSString *const kWeatherCellID = @"weatherCellID";

@interface BDWeatherViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) BDWWeather    *weather;
@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation BDWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"location":[BDPlaceManager sharedManager].placeName, @"output":@"json", @"mcode":kMCode, @"ak":kAK}];
    self.cityName = self.drawView.textFieldInput.text;
    if (self.cityName.length > 0)
    {
        [self loadRequest];
    }

}

- (void)addSubViews
{
    [super addSubViews];
    self.iconImageView.image = [UIImage imageNamed:@"weather"];
    [self.keywordField removeFromSuperview];
    self.keywordField = nil;
    
    self.drawView.frame = CGRectMake(120, 74+10+kFieldHeight/2.0, kBOUNDS.size.width-120-10, kFieldHeight);
//    self.drawView.
    __weak BDWeatherViewController *safeSelf = self;
    [self.drawView setCCTBlock:^(NSString *input){
        //进行查询
        [safeSelf.drawView setShowList:NO];
        [safeSelf loadRequest];
    }];
   
    CGFloat y = CGRectGetMaxY(self.iconImageView.frame)+10;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,y, kBOUNDS.size.width, kBOUNDS.size.height-y) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[BDWeatherCell class] forCellReuseIdentifier:kWeatherCellID];
    _tableView.rowHeight = kWeatherCellHeight;
//    _tableView.scrollEnabled = NO;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    
    [_tableView addPullToRefreshWithActionHandler:^{
        [safeSelf loadRequest];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.dataArray.count - 1 > 0 ? self.dataArray.count -1 : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDWeatherCell *cell = (BDWeatherCell *)[tableView dequeueReusableCellWithIdentifier:kWeatherCellID forIndexPath:indexPath];
    BDWWeatherData *data = self.dataArray[indexPath.section+indexPath.row];
    [cell.dayImageView sd_setImageWithURL:[NSURL URLWithString:data.dayPictureUrl]];
    [cell.nightImageView sd_setImageWithURL:[NSURL URLWithString:data.nightPictureUrl]];
    CGFloat x = CGRectGetMaxY(cell.dayImageView.frame)+kSpace+15;
    CGFloat width = [data.weather sizeOfString].width+10;
    cell.weatherLabel.text = data.weather;
    cell.weatherLabel.frame = CGRectMake(x, 5, width, kWeatherCellHeight/2-10);
    x += (width+kSpace);
    width = [data.wind sizeOfString].width+10;
    cell.windLabel.text = data.wind;
    cell.windLabel.frame = CGRectMake(x, 5, width, kWeatherCellHeight/2-10);
    x += (width+kSpace);
    width = [data.temperature sizeOfString].width+10;
    cell.tempLabel.text = data.temperature;
    cell.tempLabel.frame = CGRectMake(x, 5, width, kWeatherCellHeight/2-10);    
    cell.dateLabel.text = data.date;
//    cell.textLabel.text = data.weather;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDWeatherCell *cell = (BDWeatherCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isNight = !cell.isNight;
    if (cell.isNight)
    {
        [UIView animateWithDuration:1 animations:^{
            cell.dayImageView.hidden = YES;
            cell.nightImageView.hidden = NO;
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
        }];
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            cell.dayImageView.hidden = NO;
            cell.nightImageView.hidden = YES;
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cell cache:YES];
        }];

    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"今天";
    }
    else
    {
        return @"最近几天";
    }
}

- (void)startSelect:(UITextField *)input
{
    self.cityName = [input.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.cityName.length > 0)
    {
        [self loadRequest];
    }
}

- (void)loadRequest
{
    [self.parameters setObject:self.cityName forKey:@"location"];
    [self.manager GET:[NSString stringWithFormat:@"%@%@", kBaseAddress, kWeather] parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"---%@", [(NSDictionary *)responseObject description]);
        self.weather = [BDWWeather modelObjectWithDictionary:responseObject];
        BDWResults *result = [self.weather.results firstObject];
        self.dataArray = [NSMutableArray arrayWithArray:result.weatherData];
        [self.tableView reloadData];
        self.tableView.hidden = NO;
        [_tableView.pullToRefreshView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"天气数据请求出错 %ld, %@", error.code, error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
