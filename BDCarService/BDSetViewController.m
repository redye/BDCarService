//
//  BDSetViewController.m
//  BDCarService
//
//  Created by hu on 15/5/16.
//
//

#import "BDSetViewController.h"
#import "BDSetCell.h"
#import "FileHelper.h"
#import "UtilsHelper.h"

NSString *const kSetCellID = @"setCell";

@interface BDSetViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BDSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于";
    self.dataArray = @[@[@"当前版本"], @[@"清除缓存"], @[@"关于软件", @"关于作者"]];
    
    _tableView = [[UITableView alloc] initWithFrame:kBOUNDS style:UITableViewStyleGrouped];
    [_tableView registerClass:[BDSetCell class] forCellReuseIdentifier:kSetCellID];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section <= 1)
    {
        return 1;
    }else
    {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDSetCell *cell = (BDSetCell *)[tableView dequeueReusableCellWithIdentifier:kSetCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    if (indexPath.section <= 1)
    {
        if (indexPath.section == 0)
        {
            cell.subTextLabel.text = [FileHelper getAppVersion];
        }
        else
        {
            cell.subTextLabel.text = [NSString stringWithFormat:@"%.2fM", [FileHelper getSizeOfImage]];
        }
        cell.subTextLabel.frame = CGRectMake(cell.frame.size.width-140, 0, 100, cell.frame.size.height);
        cell.subTextLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        //清除缓存
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定清除缓存吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            //关于软件
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"出行必备神器" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            return;
        }
        else
        {
            //关于作者
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"作者是11级计算机2班童鞋 redye 胡永红 \n tel：18297607402" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
            [alertView show];
            return;

        }
    }
}

#pragma mark - UIAlertViewDeleagte
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        return;
    }
    else
    {
        //清除缓存
        [FileHelper cleanCache];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }
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
