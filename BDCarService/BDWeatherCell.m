//
//  BDWeatherCell.m
//  BDCarService
//
//  Created by hu on 15/5/17.
//
//

#import "BDWeatherCell.h"

@implementation BDWeatherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _dayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (kWeatherCellHeight-23)/2, 40, 23)];
        _dayImageView.layer.cornerRadius = 5;
        _dayImageView.layer.masksToBounds = YES;
        [self addSubview:_dayImageView];
        _nightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (kWeatherCellHeight-23)/2, 40, 23)];
        _nightImageView.hidden = YES;
        _nightImageView.layer.cornerRadius = 5;
        _nightImageView.layer.masksToBounds = YES;
        [self addSubview:_nightImageView];
        
        _weatherLabel = [[UILabel alloc] init];
        _weatherLabel.layer.cornerRadius = 5;
        _weatherLabel.layer.masksToBounds = YES;
        _weatherLabel.backgroundColor = kRGB(248, 248, 255);
        _weatherLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_weatherLabel];
        
        _windLabel = [[UILabel alloc] init];
        _windLabel.layer.cornerRadius = 5;
        _windLabel.layer.masksToBounds = YES;
        _windLabel.textAlignment = NSTextAlignmentCenter;
        _windLabel.backgroundColor = kRGB(240, 255, 255);
        [self addSubview:_windLabel];
        
        _tempLabel = [[UILabel alloc] init];
        _tempLabel.layer.cornerRadius = 5;
        _tempLabel.layer.masksToBounds = YES;
        _tempLabel.textAlignment = NSTextAlignmentCenter;
        _tempLabel.backgroundColor = kRGB(224, 255, 255);
        [self addSubview:_tempLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+40+kSpace, kWeatherCellHeight/2, self.frame.size.width-(15+40+kSpace*2), kWeatherCellHeight/2)];;
        [self addSubview:_dateLabel];

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
