//
//  BDMenuCell.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "BDMenuCell.h"

@implementation BDMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
        _iconImageView.layer.cornerRadius = 5;
        _iconImageView.layer.masksToBounds = YES;
        
        _iconLabel = [[UILabel alloc] init];
        [self addSubview:_iconLabel];
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
