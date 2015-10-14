//
//  BDMovieViewController.m
//  BDCarService
//
//  Created by hu on 15/5/16.
//
//

#import "BDMovieViewController.h"
#import "UICollectionViewWaterfallLayout.h"
#import "BDMovieCell.h"
#import "BDMMovieModels.h"
#import "UIImageView+WebCache.h"
#import "BDMovieInfoViewController.h"

#define kWIDTH kBOUNDS.size.width/2 -10
#define kIMAGE_WIDTH 104
#define KIMAGE_HEIGHT 143
#define kCELL_HEIGHT KIMAGE_HEIGHT*(kWIDTH)/kIMAGE_WIDTH

NSString *const kMovieCellID = @"movieCellID";

@interface BDMovieViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BDMMovies         *movies;

@end

@implementation BDMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityName = self.drawView.textFieldInput.text;
    
    NSDictionary *dic = nil;
    if (self.cityName.length > 0)
    {
        dic =  @{@"qt":@"hot_movie", @"location":self.cityName, @"output":@"json", @"mcode":kMCode, @"ak":kAK};
    }
    else
    {
        dic =  @{@"qt":@"hot_movie", @"location":@"", @"output":@"json", @"mcode":kMCode, @"ak":kAK};
    }
    
    self.parameters = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self loadRequest];

}

- (void)addSubViews
{
    [super addSubViews];
    self.iconImageView.image = [UIImage imageNamed:@"movie"];
    self.keywordField.hidden = YES;
    
    __weak BDMovieViewController *safeSelf = self;
    [self.drawView setCCTBlock:^(NSString *cityName){
        safeSelf.cityName = cityName;
        [safeSelf loadRequest];
    }];
    
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.itemWidth = kBOUNDS.size.width/2 -10;
    layout.delegate = self;
    CGFloat y = CGRectGetMaxY(self.iconImageView.frame)+10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, y, kBOUNDS.size.width-10, kBOUNDS.size.height-y) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[BDMovieCell class] forCellWithReuseIdentifier:kMovieCellID];
    [self.view addSubview:self.collectionView];
    [self.collectionView addPullToRefreshWithActionHandler:^{
        [safeSelf loadRequest];
    }];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [UtilsHelper showActivityIndicatorOnView:self.view];
}

- (void)startSelect:(UITextField *)input
{
    self.cityName = [input.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.cityName.length > 0)
    {
        [self loadRequest];
        [[BDPlaceManager sharedManager] insertToPlaceArrayWithObject:self.cityName];
        [self.drawView reloadListWithData:[BDPlaceManager sharedManager].placeArray];
    }
    [self.drawView setShowList:NO];
}

- (void)loadRequest
{
    self.collectionView.contentOffset = CGPointMake(0, 0);
    
    [self.parameters setObject:self.cityName forKey:@"location"];
    
    [self.manager GET:[NSString stringWithFormat:@"%@%@", kBaseAddress, kMovie] parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", [(NSDictionary *)responseObject description]);
        self.movies = [BDMMovies modelObjectWithDictionary:responseObject];
        self.dataArray = [NSMutableArray arrayWithArray:self.movies.result.movie];
        [self.collectionView reloadData];
        [self.collectionView.pullToRefreshView stopAnimating];
        [UtilsHelper removeActivityIndicatorFromView:self.view];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"热映影片数据获得出错 %ld, %@", error.code, error.localizedDescription);
        [UIView animateWithDuration:0 animations:^{
            [UtilsHelper showFailedInfo:@"数据请求失败" onView:self.view];
        } completion:^(BOOL finished) {
            [NSThread sleepForTimeInterval:2];
            [UtilsHelper removeFailedInfoOnView:self.view];
        }];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDMovieCell *cell = (BDMovieCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kMovieCellID forIndexPath:indexPath];
    BDMMovie *movie = [self.dataArray objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:movie.moviePicture]];
    cell.imageView.frame = CGRectMake(0, 0, kWIDTH, kCELL_HEIGHT);
    cell.nameLabel.text = movie.movieName;
    cell.nameLabel.frame = CGRectMake(0, kCELL_HEIGHT+10, kWIDTH, 44);
    cell.scoreLabel.text = movie.movieScore;
    cell.scoreLabel.frame = CGRectMake(kWIDTH-35, kCELL_HEIGHT+10+7, 30, 30);
    cell.scoreLabel.layer.cornerRadius = 15;
    NSArray *tags = [movie.movieTags componentsSeparatedByString:@","];
    cell.tagView.frame = CGRectMake(0, kCELL_HEIGHT+10+44, kWIDTH, 44);
    [cell.tagView addTagsWithArray:tags];
    return cell;
}

#pragma mark - UICollectionViewDelegateWaterfallLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return kCELL_HEIGHT + 44 * 2 +10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDMMovie *movie = [self.dataArray objectAtIndex:indexPath.row];
    BDMovieInfoViewController *infoController = [[BDMovieInfoViewController alloc] init];
    infoController.movieName = movie.movieName;
    infoController.cityName = self.cityName;
    self.detailsBlock(infoController);
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
