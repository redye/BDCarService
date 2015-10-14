//
//  BDMovieInfoViewController.m
//  BDCarService
//
//  Created by hu on 15/5/19.
//
//

#import "BDMovieInfoViewController.h"
#import "AFNetworking.h"
#import "BDInfoCell.h"
#import "BDInfoHeader.h"
#import "BDIInfoModels.h"
#import "UtilsHelper.h"

NSString *const kMovieInfoCellID = @"movieInfoCellID";
NSString *const kMovieInfoHeaderID = @"movieInfoHeaderID";

@interface BDMovieInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) BDIInfo        *info;
@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation BDMovieInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.movieName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubViews];
    [self loadRequest];
}

- (void)addSubViews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[BDInfoCell class] forCellReuseIdentifier:kMovieInfoCellID];
    [_tableView registerClass:[BDInfoHeader class] forHeaderFooterViewReuseIdentifier:kMovieInfoHeaderID];
    _tableView.rowHeight = 50;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    
    [UtilsHelper showActivityIndicatorOnView:self.view];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDInfoCell *cell = (BDInfoCell *)[tableView dequeueReusableCellWithIdentifier:kMovieInfoCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BDITimeTable *timeTable = _dataArray[indexPath.section][indexPath.row];
    [cell updateDataWithTimeTable:timeTable];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDInfoHeader *header = (BDInfoHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kMovieInfoHeaderID];
    if (!header)
    {
        header = [[BDInfoHeader alloc] initWithReuseIdentifier:kMovieInfoHeaderID];
        [header setExpandBlock:^(BOOL isExpand){
            if (isExpand)
            {
                
            }
        }];
    }
    BDIResult *result = _sectionArray[section];
    header.nameLabel.text = result.name;
    header.teleLabel.text = result.telephone;
    header.addresslabel.text = result.address;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (void)loadRequest
{
    NSDictionary *parameters = @{@"qt":@"search_movie", @"wd":_movieName, @"location":_cityName, @"output":@"json", @"mcode":kMCode, @"ak":kAK};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@", kBaseAddress, kMovie] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", [(NSDictionary *)responseObject description]);
        self.info = [BDIInfo modelObjectWithDictionary:responseObject];
        [self updateDataAndTable];
        self.tableView.hidden = NO;
        [UtilsHelper removeActivityIndicatorFromView:self.view];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"影讯查询失败 %ld, %@", error.code, error.localizedDescription);
        [UtilsHelper removeActivityIndicatorFromView:self.view];
    }];
}

- (void)updateDataAndTable
{
    self.sectionArray = [NSMutableArray arrayWithArray:self.info.result];
    self.dataArray = [NSMutableArray array];
    for (BDIResult *result in self.sectionArray)
    {
        [self.dataArray addObject:result.timeTable];
    }
    [_tableView reloadData];
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
