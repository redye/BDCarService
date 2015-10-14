
//
//  BDSendToCarViewController.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "BDFunnyPointViewController.h"
#import "BDDrawListView.h"
#import "AFNetworking.h"
#import "BDFunnyModels.h"
#import "BDFunnyDetailsViewController.h"

NSString *const kFunnyCellID = @"funnyPoint";

@interface BDFunnyPointViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BDDrawListView   *_listView;
}

@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) BDFunnyPoint       *funnyPoint;
@property (nonatomic, assign) BOOL                isFirst;

@end

@implementation BDFunnyPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirst = YES;
}

- (void)addSubViews
{
    [super addSubViews];
    
    self.iconImageView.image = [UIImage imageNamed:@"around"];
    
    
    __weak BDFunnyPointViewController *safeSelf = self;
    [self.drawView setCCTBlock:^(NSString *cityName){
        safeSelf.cityName = cityName;
        safeSelf.tableView.contentOffset = CGPointMake(0, 0);
        safeSelf.page = 0;
        [safeSelf comfirmInput];
    }];
    
    _listView = [[BDDrawListView alloc] initWithFrame:CGRectMake(120, 74+33, kBOUNDS.size.width-130, kBOUNDS.size.height/2)];
    _listView.dataDictionary = @{@"中餐馆":@[@"鲁菜", @"川菜", @"粤菜", @"徽菜", @"台湾菜", @"贵州菜", @"江浙菜", @"湘菜", @"湖北菜", @"清真菜"], @"西餐厅":@[@"意大利菜", @"法国菜", @"德国菜", @"俄罗斯菜", @"拉美烧烤", @"中东料理", @"披萨", @"牛排"], @"日本菜":@[@"日本料理", @"日式烧烤", @"寿司"], @"韩国菜":[NSArray array], @"东南亚菜":@[@"泰国菜", @"越南菜", @"印度菜", @"菲律宾菜", @"印尼风味"], @"自助餐":[NSArray array], @"快餐":@[@"中式快餐", @"西式快餐"], @"小吃":@[@"粉面馆", @"粥店", @"饺子馆", @"馄饨店", @"麻辣烫"], @"蛋糕甜点":@[@"蛋糕西点", @"冰淇淋", @"甜点饮品"], @"星级酒店":@[@"五星级酒店", @"四星级酒店", @"三星级酒店"], @"快捷酒店":[NSArray array], @"公寓式酒店":[NSArray array], @"旅店":@[@"家庭旅店", @"青年旅店", @"招待所"], @"其他":[NSArray array], @"购物中心":[NSArray array], @"超市/便利店":[NSArray array], @"家电":@[@"空调", @"冰箱", @"洗衣机", @"微波炉"]};
    _listView.secDictionary = @{@"美食": @[@"中餐馆", @"西餐厅", @"日本菜", @"韩国菜", @"东南亚菜", @"自助餐", @"快餐", @"小吃"], @"宾馆":@[@"星级酒店", @"快捷酒店", @"旅店", @"其他"], @"购物":@[@"购物中心", @"超市/便利店", @"家电"]};
    
    //添加KVO观察者
    [_listView addObserver:self forKeyPath:@"keyItem" options:NSKeyValueObservingOptionNew context:nil];
    [_listView reload];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopPadding, kBOUNDS.size.width, kBOUNDS.size.height-kTopPadding) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.hidden = YES;
    _tableView.rowHeight = kCellHeight;
    [self.view addSubview:_tableView];
    
    //下拉刷新
    [_tableView addPullToRefreshWithActionHandler:^{
        safeSelf.page = 0;
        [safeSelf loadRequest];
    }];
    
    
    //上拉加载跟多
    [_tableView addInfiniteScrollingWithActionHandler:^{
        safeSelf.page ++;
        [safeSelf loadRequest];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFunnyCellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kFunnyCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    PointList *pointList = self.dataArray[indexPath.row];
    cell.textLabel.text = pointList.name;
    cell.detailTextLabel.text = pointList.address;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDFunnyDetailsViewController *detailsController = [[BDFunnyDetailsViewController alloc] init];
    detailsController.pointList = self.dataArray[indexPath.row];
    self.detailsBlock(detailsController);
}

#pragma mark - KVO 观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.keywordField.text = change[@"new"];
    [_listView removeFromSuperview];
    self.keywordField.enabled = YES;
    self.keyword = change[@"new"];
    self.cityName = self.drawView.textFieldInput.text;
    
    if (self.cityName.length > 0)
    {
        [self comfirmInput];
        [self.drawView setShowList:NO];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addSubview:_listView];
     textField.enabled = NO;
}

#pragma mark - 开始查询：按回车键开始查询
- (void)startSelect:(UITextField *)sender
{
    [self.drawView setShowList:NO];
    self.keyword = self.keywordField.text;
    self.cityName = [self.drawView.textFieldInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.drawView setShowList:NO];
    
    [self comfirmInput];
}

- (void)comfirmInput
{
    if (self.keyword.length<=0 || self.cityName.length<=0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入关键字或城市名" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alertView show];
        return;
    }
    
    //将新查询的地址加入历史查询
    [[BDPlaceManager sharedManager] insertToPlaceArrayWithObject:self.cityName];
    [self.drawView reloadListWithData:[BDPlaceManager sharedManager].placeArray];
    
    NSDictionary *parameters = @{@"keyWord":self.keyword, @"cityName":self.cityName, @"number":@20, @"page":[NSNumber numberWithInteger:self.page], @"mcode":kMCode, @"output":@"json", @"ak":kAK};
    self.parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    [self loadRequest];
}

- (void)loadRequest
{
    if (self.isFirst)
    {
        [UtilsHelper showActivityIndicatorOnView:self.view];
    }
    [self.parameters setObject:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    [self.manager GET:[NSString stringWithFormat:@"%@%@", kBaseAddress, kFunnyPoint] parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"---%@", [(NSDictionary *)responseObject description]);
        self.funnyPoint = [BDFunnyPoint modelObjectWithDictionary:responseObject];
        if (self.page == 0)
        {
            self.dataArray = [NSMutableArray arrayWithArray:self.funnyPoint.pointList];
        }
        else
        {
            [self.dataArray addObjectsFromArray:self.funnyPoint.pointList];
        }
        _tableView.hidden = NO;
        [_tableView reloadData];
        //停止动画
        [_tableView.pullToRefreshView stopAnimating];
        [_tableView.infiniteScrollingView stopAnimating];
        [UtilsHelper removeActivityIndicatorFromView:self.view];
        self.isFirst = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"兴趣点搜索出错 %ld, %@", error.code, error.localizedDescription);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [_listView setShowDrawView:NO];
    [self.drawView setShowList:NO];
}

- (void)dealloc
{
    [_listView removeObserver:self forKeyPath:@"keyItem"];
}
@end
