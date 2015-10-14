//
//  BDInfoCell.m
//  BDCarService
//
//  Created by hu on 15/5/19.
//
//

#import "BDInfoCell.h"
#import "NSString+Additions.h"

@implementation BDInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 25)];
//        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 100, 25)];
        [self addSubview:_dateLabel];
        
        CGFloat width = [@"类型" sizeOfString].width;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, width, 25)];
        label1.text = @"类型";
        [self addSubview:label1];
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+width+10, 25, width*2, 25)];
        _typeLabel.textColor = [UIColor orangeColor];
        [self addSubview:_typeLabel];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15+width+(width+10)*2, 25, width, 25)];
        label2.text = @"价格";
        [self addSubview:label2];
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+width+(width+10)*3, 25, width, 25)];
        _priceLabel.textColor = [UIColor redColor];
        [self addSubview:_priceLabel];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(15+width+(width+10)*4, 25, width, 25)];
        label3.text = @"语言";
        [self addSubview:label3];
        _lanLabel =  [[UILabel alloc] initWithFrame:CGRectMake(15+width+(width+10)*5, 25, width+20, 25)];
        _lanLabel.textColor = kRGB(0, 91, 255);
        [self addSubview:_lanLabel];

    }
    
    return self;
}

- (void)awakeFromNib {
}

- (void)updateDataWithTimeTable:(BDITimeTable *)timeTable
{
    self.timeLabel.text = timeTable.time;
    self.dateLabel.text = timeTable.date;
    self.typeLabel.text = timeTable.type;
    self.priceLabel.text = [NSString stringWithFormat:@"%.0f", timeTable.price];
    self.lanLabel.text = timeTable.lan;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
