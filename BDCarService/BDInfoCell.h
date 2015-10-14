//
//  BDInfoCell.h
//  BDCarService
//
//  Created by hu on 15/5/19.
//
//

#import <UIKit/UIKit.h>
#import "BDIInfoModels.h"

@interface BDInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *lanLabel;

- (void)updateDataWithTimeTable:(BDITimeTable *)timeTable;

@end
