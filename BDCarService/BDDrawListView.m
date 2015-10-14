//
//  BDDrawList.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "BDDrawListView.h"
#import "UITableView+Additions.h"

NSString *const kMainCell = @"mainCell";
NSString *const kSubCell = @"subCell";


@interface BDDrawListView () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_mainTableView;
    UITableView *_subTableView;
}

@property (nonatomic, strong) NSArray      *sectionArray;
@property (nonatomic, strong) NSArray      *mainArray;
@property (nonatomic, strong) NSArray      *subArray;

@end

@implementation BDDrawListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height) style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMainCell];
        _mainTableView.type = UITableViewMain;
        _mainTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_mainTableView];
        
        _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height) style:UITableViewStylePlain];
        _subTableView.dataSource = self;
        _subTableView.delegate = self;
        [_subTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSubCell];
        _subTableView.type = UITableViewSub;
        _subTableView.hidden = YES;
        _subTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_subTableView];
    }
    
    return self;
}

- (void)reload
{
    self.sectionArray = [_secDictionary allKeys];

    [_mainTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.type == UITableViewMain)
    {
        return _sectionArray.count;
    }
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.type == UITableViewMain)
    {
        self.mainArray = [_secDictionary objectForKey:_sectionArray[section]];
        return _mainArray.count;
    }
    
    //子表
    if (_subArray.count > 0)
    {
        tableView.hidden = NO;
        return _subArray.count;
    }
    else
    {
        tableView.hidden = YES;
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (tableView.type == UITableViewMain)
    {
        self.mainArray = [_secDictionary objectForKey:_sectionArray[indexPath.section]];
        cell = [tableView dequeueReusableCellWithIdentifier:kMainCell forIndexPath:indexPath];
        cell.textLabel.text = _mainArray[indexPath.row];
        return cell;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:kSubCell forIndexPath:indexPath];
        cell.textLabel.text = _subArray[indexPath.row];
        return cell;
    }
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选择对应的组出现对应的所有值
    if (tableView.type == UITableViewMain)
    {
        self.mainArray = _secDictionary[_sectionArray[indexPath.section]];
        if ([_dataDictionary[_mainArray[indexPath.row]] count] <= 0)
        {
            self.keyItem = _mainArray[indexPath.row];
            self.subArray = nil;
            [_subTableView reloadData];
            return;
        }
        self.subArray = _dataDictionary[_mainArray[indexPath.row]];
        [_subTableView reloadData];
        return;
    }
    
    //选择可一个选项作为关键词：KVO获得选择的值
    self.keyItem = _subArray[indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.type == UITableViewMain)
    {
        return _sectionArray[section];
    }
    
    return nil;
}

- (void)setShowDrawView:(BOOL)b
{
    self.hidden = !b;
}

@end
