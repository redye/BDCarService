//
//  NSString+Additions.m
//  xiaomu
//
//  Created by hu on 15/5/5.
//  Copyright (c) 2015年 mecallytech. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (CGSize)sizeOfString
{
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName: kFont(17)}];
    
    return size;
}

- (NSString *)subString
{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    //取出字符串中的中文字符
    NSRange range = [mutableString rangeOfString:@"<"];
    
    while (range.length != 0)
    {
        NSRange range2 = [mutableString rangeOfString:@">"];
        [mutableString deleteCharactersInRange:NSMakeRange(range.location, range2.location-range.location+1)];
        range = [mutableString rangeOfString:@"<"];
    }
    
    return mutableString;
}

- (CGSize)sizeOfStringWithFontSize:(NSInteger)fontSize
{
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName: kFont(fontSize)}];
    
    return size;
}

@end
