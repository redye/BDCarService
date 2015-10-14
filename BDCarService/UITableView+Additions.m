
//
//  UITableView+Additions.m
//  BDCarService
//
//  Created by hu on 15/5/10.
//
//

#import "UITableView+Additions.h"

#define kType @"type"

@implementation UITableView (Additions)

- (void)setType:(NSInteger)type
{
    objc_setAssociatedObject(self, kType, [NSNumber numberWithInteger:type], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)type
{
    NSInteger type = 0;
    type = [objc_getAssociatedObject(self, kType) integerValue];
    return type;
}

@end
