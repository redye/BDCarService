//
//  BDInfoHeader.h
//  BDCarService
//
//  Created by hu on 15/5/19.
//
//

#import <UIKit/UIKit.h>

typedef void(^SectionWillExpandBlock)(BOOL);

@interface BDInfoHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *teleLabel;
@property (nonatomic, strong) UILabel *addresslabel;
@property (nonatomic, assign) BOOL     isExpand;
@property (nonatomic, copy) SectionWillExpandBlock expandBlock;

@end
