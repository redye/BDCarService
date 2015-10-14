//
//  BDWayCell.m
//  BDCarService
//
//  Created by hu on 15/5/22.
//
//

#import "BDWayCell.h"

@implementation BDWayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(15, 10, CGRectGetMaxX(kBOUNDS)-15, 20)];
        [self addSubview:_nameLabel];
        
        _locaionLabel = [[UILabel alloc] initWithFrame: CGRectMake(15, 30, CGRectGetMaxX(kBOUNDS)-15, 20)];
        [self addSubview:_locaionLabel];

        _addressLabel = [[UILabel alloc] init];
        _addressLabel.frame = CGRectMake(10, 50, CGRectGetMaxX(kBOUNDS)-15, 20);
        [self addSubview:_addressLabel];
        
        _webView = [[UIWebView alloc] initWithFrame: CGRectMake(15, 50, CGRectGetMaxX(kBOUNDS)-15, 30)];
        [self addSubview:_webView];
        
        _speedLabel = [[UILabel alloc] initWithFrame: CGRectMake(CGRectGetMaxX(kBOUNDS)-60, (80-40)/2, 40, 40)];
        [self addSubview:_speedLabel];
        _speedLabel.layer.cornerRadius = 20;
        _speedLabel.layer.masksToBounds = YES;
        _speedLabel.textColor = [UIColor whiteColor];
        _speedLabel.textAlignment = NSTextAlignmentCenter;
        _speedLabel.backgroundColor = [UIColor redColor];

    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
