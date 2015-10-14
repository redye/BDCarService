//
//  BDWayHeader.h
//  BDCarService
//
//  Created by hu on 15/5/23.
//
//

#import <UIKit/UIKit.h>

typedef void(^HeaderDidSelectedBlock)(BOOL);

@interface BDWayHeader : UITableViewHeaderFooterView

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy) HeaderDidSelectedBlock selectedBlock;

@end
