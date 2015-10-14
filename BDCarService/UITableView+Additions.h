//
//  UITableView+Additions.h
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef enum {
    UITableViewMain = 0,
    UITableViewSub
}UITableViewType;

@interface UITableView (Additions)

@property (nonatomic, assign) NSInteger type;

@end
