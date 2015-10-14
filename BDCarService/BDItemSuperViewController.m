//
//  BDItemSuperViewController.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "BDItemSuperViewController.h"

@interface BDItemSuperViewController ()<UITextFieldDelegate>

@end

@implementation BDItemSuperViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kHistory];
    [BDPlaceManager sharedManager].placeArray = [NSMutableArray arrayWithArray:array];
     self.manager = [AFHTTPRequestOperationManager manager];
    
    [self addSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.drawView setShowList:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.drawView setShowList:NO];
    [super viewWillDisappear:animated];
}


- (void)addSubViews
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64, 100, 96)];
    [self.view addSubview:_iconImageView];
    
    //添加关键词搜索与城市名
    _keywordField = [[UITextField alloc] initWithFrame:CGRectMake(120, 74, kBOUNDS.size.width-120-10, kFieldHeight)];
    _keywordField.placeholder = @"请输入您想要搜索的兴趣点";
    _keywordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _keywordField.borderStyle = UITextBorderStyleRoundedRect;
    _keywordField.delegate = self;
    [self.view addSubview:_keywordField];
    
    _drawView = [[BoxDropDownList alloc] initWithFrame:CGRectMake(120, 74+10+kFieldHeight, kBOUNDS.size.width-120-10, kFieldHeight) withListArr:[BDPlaceManager sharedManager].placeArray withPlaceholder:@"请输入您所在的城市" withBlock:nil];
    _drawView.textFieldInput.text = [BDPlaceManager sharedManager].placeName;
    [_drawView.textFieldInput addTarget:self action:@selector(startSelect:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_drawView];

}

- (void)startSelect:(UITextField *)input
{

}

- (void)loadRequest
{

}

@end
