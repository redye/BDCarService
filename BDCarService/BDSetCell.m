//
//  BDSetCell.m
//  BDCarService
//
//  Created by hu on 15/5/16.
//
//

#import "BDSetCell.h"

@implementation BDSetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _subTextLabel = [[UILabel alloc] init];
        [self addSubview:_subTextLabel];

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
