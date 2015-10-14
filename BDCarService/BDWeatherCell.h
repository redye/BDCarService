//
//  BDWeatherCell.h
//  BDCarService
//
//  Created by hu on 15/5/17.
//
//

#import <UIKit/UIKit.h>

#define kSpace 20
#define kWeatherCellHeight 60

@interface BDWeatherCell : UITableViewCell

@property (nonatomic, strong) UIImageView *dayImageView;
@property (nonatomic, strong) UIImageView *nightImageView;
@property (nonatomic, strong) UILabel     *weatherLabel;
@property (nonatomic, strong) UILabel     *windLabel;
@property (nonatomic, strong) UILabel     *tempLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, assign) BOOL         isNight;

@end
