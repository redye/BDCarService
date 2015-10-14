//
//  BDMenuViewController.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "BDLeftViewController.h"
#import "BDMenuCell.h"

#define kIMAGE_HEIGHT 47
#define kCELL_HEIGHT 60

NSString *const kCellID = @"menuCell";

@interface BDLeftViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray    *menuArray;
@property (nonatomic, strong) NSArray    *detailArray;


@end

@implementation BDLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.menuArray = @[@"兴趣点搜索", @"周边搜索", @"交通事件查询", @"测距", @"驾车搜索", @"地理/逆地理编码", @"途径路段消息", @"天气查询", @"旅游线路查询", @"景点详情查询", @"热映影片/影讯查询"];
    
    self.menuArray = @[@"兴趣点搜索", @"途径路段消息", @"天气查询", @"热映影片/影讯查询"];
    
    self.detailArray = @[@"根据关键字查询POI信息（百度地图拥有的几千万兴趣点数据）", @"根据中心点位置、检索半径、关键字查询周边信息。如附近的4S店，加油站等", @"根据城市名称或经纬度查询交通事件信息，如施工、禁行等", @"提供测量多点之间的直线距离", @"根据起终点，查询城市内或跨城市的驾车路线方案", @"坐标和地址信息之间的相互转换功能", @"根据起终点查询途径路段的信息，包括主要路段、红绿灯、摄像头等", @"根据经纬度/城市名提供查询天气的结果", @"根据城市名称、城市代码、坐标查询城市 旅游路线", @"根据POI 名称、UID查询景点详细信息", @"根据城市名称、城市代码、坐标查询城市热映影片; 根据影片/影院名称查询实时影讯"];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    CGFloat logoHeigh = kBOUNDS.size.width/2 * 40 /207;
    logoImageView.frame = CGRectMake(0, 20, kBOUNDS.size.width/2, logoHeigh);
    [self.view addSubview:logoImageView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20+logoHeigh+10, kBOUNDS.size.width, kBOUNDS.size.height-20-logoHeigh-10) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = kCELL_HEIGHT;
    [self.view addSubview:tableView];

    
}

#pragma mark - UITableVIewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDMenuCell *cell = (BDMenuCell *)[tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell)
    {
        cell = [[BDMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", indexPath.row]];
    cell.iconImageView.frame = CGRectMake(15, (kCELL_HEIGHT-kIMAGE_HEIGHT)/2, kIMAGE_HEIGHT, kIMAGE_HEIGHT);
    cell.iconLabel.text = _menuArray[indexPath.row];
    cell.iconLabel.frame = CGRectMake(kIMAGE_HEIGHT+25, 0, kBOUNDS.size.width-kIMAGE_HEIGHT-10, kCELL_HEIGHT);
//    cell.detailTextLabel.text = _detailArray[indexPath.row];
//    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kBDMenuDidChangeNotification object:self userInfo:@{kMenuItem: _menuArray[indexPath.row], kMenuType:[NSNumber numberWithInteger:indexPath.row]}];
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
