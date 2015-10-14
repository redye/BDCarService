//
//  NSString+Additions.h
//  xiaomu
//
//  Created by hu on 15/5/5.
//  Copyright (c) 2015年 mecallytech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)

- (CGSize)sizeOfString;
//去除字符串中的多余字符，针对有html的字符串
- (NSString *)subString;

@end
